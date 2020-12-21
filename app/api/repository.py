from app.database.users import UsersCollection
from app.database.doctor import DoctorsCollection
from app.database.patient import PatientsCollection
from app.database.hospital import HospitalCollection
from app.database.schedule import ScheduleCollection
from app.database.appointment import AppointmentsCollection
from app.database.disease_history import HistoriesCollection

from datetime import datetime

class Repository:
    @classmethod
    def __get_obj_by_id(cls, collection, user_id):
        """
        Get object's info by id
        :param collection:
        :param user_id: id of object
        :return: object's data
        """
        return collection.to_json(collection.get_one_obj({'_id': user_id}))

    @classmethod
    def __get_all_users(cls, collection, **filter_data):
        """
        Get all user data combine user data and collection data
        :param collection: collection object
        :param filter_data: filter for fields in :collection:   !
        :param fields: fields to output
        :return: list of user's data
        """
        user_list = collection.to_json(collection.get_objs(filter_data))

        if not user_list:
            return []

        for i in range(len(user_list)):
            user_data = cls.__get_obj_by_id(UsersCollection, user_list[i]['user_id'])
            user_list[i] = {**user_list[i], **user_data}
            del user_list[i]['password']

        return user_list

    @classmethod
    def __get_users_where(cls, collection, **filter):  
        """
         # in theory, can replace __get_all_users as more general
        Get all user data combine user data and collection data
        :param collection: collection object
        :param filter_data: filter for fields in both :collection: and UserCollection 
        :param fields: fields to output
        :return: list of user's data

        Birthday filtering doesn't work. Reason unknown 
        """
        if collection is DoctorsCollection:
            role = 'doctor'
        elif collection is PatientsCollection:
            role = 'patient'
        user_list = collection.to_json(UsersCollection.get_objs(dict(role=role)))  # getting users by role(only filtering atr we know)(for speed??)
    
        for i in range(len(user_list)):   # getting addditional data from role collection and merging with users
            role_data = collection.get_one_obj(dict(user_id=user_list[i]['_id'])) 
            user_list[i].update(role_data)
            del user_list[i]['password']

        res = []
        for i in range(len(user_list)):  # filtering loop
            for atr, reqVal in filter.items():   
                if user_list[i][atr] != reqVal:   
                    break
            else: 
                res.append(user_list[i]) # executed if loop didn't break
        return res

    @classmethod
    def __get_user_profile(cls, collection, user_id):
        """
        Get all data about user by id//
        :param collection: collection of user
        :param user_id: user's id
        :return: user's data
        """
        user_data = cls.__get_obj_by_id(UsersCollection, user_id)
        collection_data = collection.to_json(collection.get_one_obj({'user_id': user_id}))

        if not collection_data:
            return None

        user_data = {**collection_data, **user_data}
        del user_data['password']

        return user_data

    @classmethod
    def __get_all_items(cls, collection, **filter_data):
        return collection.to_json(collection.get_objs(filter_data))

    @classmethod
    def __insert_obj_to_collection(cls, collection, obj):
        """
        Insert to collection new object
        :param collection: Collection name
        :param obj: New object
        :return: new collection data
        """
        return collection.insert_obj(dict(obj))

    @classmethod
    def __update_obj(cls, collection, obj_id, new_obj):
        if obj_id in collection.get_ids():
            collection.update_obj_by_id(obj_id, dict(new_obj))
            return 'Success update', True
        else:
            return 'Can\'n found by this id', False

    @classmethod
    def __delete_obj(cls, collection, obj_id):
        if obj_id in collection.get_ids():
            collection.delete_obj_by_id(obj_id)
            return 'Success delete', True
        return 'Can\'n found by this id', False

    @classmethod
    def get_patient_by_id(cls, user_id):
        patient_profile = cls.__get_user_profile(PatientsCollection, user_id)

        return patient_profile

    @classmethod
    def get_patient_by_dict(cls, filter_dict):
        patients = cls.__get_users_where(PatientsCollection, **filter_dict)
        
        return patients

    @classmethod
    def get_all_patients(cls):
        list_patients = cls.__get_all_users(PatientsCollection)

        return list_patients

    @classmethod
    def get_doctor_by_id(cls, user_id):
        doctor_profile = cls.__get_user_profile(DoctorsCollection, user_id)

        return doctor_profile

    @classmethod
    def get_doctor_by_dict(cls, filter_dict):
        list_doctors = cls.__get_users_where(DoctorsCollection, **filter_dict)
        
        return list_doctors

    @classmethod
    def get_all_doctors(cls):
        list_doctors = cls.__get_all_users(DoctorsCollection)

        return list_doctors

    @classmethod
    def get_hospital_by_id(cls, hospital_id):
        hospital_profile = cls.__get_obj_by_id(HospitalCollection, hospital_id)

        return hospital_profile

    @classmethod
    def get_all_hospitals(cls):
        list_hospitals = cls.__get_all_items(HospitalCollection)

        return list_hospitals

    @classmethod
    def get_doctors_by_hospital_id(cls, hospital_id):
        list_doctors = cls.__get_all_users(DoctorsCollection, hospital_id=hospital_id)

        return list_doctors

    @classmethod
    def get_histories_by_patient_id(cls, patient_id):
        histories_patient = cls.__get_all_items(HistoriesCollection, patient_id=patient_id)

        return histories_patient

    @classmethod
    def get_history_by_id(cls, history_id):
        history = cls.__get_obj_by_id(HistoriesCollection, history_id)

        return history

    @classmethod
    def get_schedule(cls, doctor_id):
        schedule_data = ScheduleCollection.get_objs({'doctor_id': str(doctor_id)},
                                                    fields=(
                                                    '_id', 'doctor_id', 'weekDay', 'startDateTime', 'finishDateTime',
                                                    'hospital', 'room'))
        if not schedule_data:
            return {'data': {}, 'result': False}
        return {'data': schedule_data, 'result': True}

    @classmethod
    def get_appointments_by_patient(cls, patient_id):
        result = AppointmentsCollection.get_objs({'patient_id': patient_id})

        return result

    @classmethod
    def get_appointments_by_doctor(cls, doctor_id):
        result = AppointmentsCollection.get_objs({'doctor_id': doctor_id})

        return result

    @classmethod
    def get_appointments_by_filter(cls, filter):
        result = AppointmentsCollection.get_objs(filter)

        return result

    @classmethod
    def add_history(cls, history):
        cls.__insert_obj_to_collection(HistoriesCollection, history)
        
    @classmethod
    def add_patient(cls, patient):
        return cls.__insert_obj_to_collection(PatientsCollection, patient)

    @classmethod
    def add_user(cls, user):
        return cls.__insert_obj_to_collection(UsersCollection, user)

    @classmethod
    def update_history(cls, history_id, history):
        result = cls.__update_obj(HistoriesCollection, history_id, history)

        return result

    @classmethod
    def delete_history(cls, history_id):
        result = cls.__delete_obj(HistoriesCollection, history_id)

        return result

    @classmethod
    def add_appointment(cls, appointment):
        result = cls.__insert_obj_to_collection(AppointmentsCollection, appointment)

        return result

    @classmethod
    def delete_appointment(cls, appointment_id):
        result = cls.__delete_obj(AppointmentsCollection, appointment_id)

        return result