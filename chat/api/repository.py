from chat.database.message import MessagesCollection

import datetime



class Repository:


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
    def save_message(cls, doctor_id, patient_id, sender, text):
        status = cls.__insert_obj_to_collection(MessagesCollection, {
                                        'doctor_id':doctor_id,
                                        'patient_id':patient_id,
                                        'sender':sender,
                                        'text':text,
                                        'dateCreated':datetime.datetime.now()
                                           })
        return status

    @classmethod
    def get_chat_messages(cls, doctor_id, patient_id):
        result = MessageCollection.get_objs({'doctor_id':doctor_id, 'patient_id':patient_id})

        return result
        