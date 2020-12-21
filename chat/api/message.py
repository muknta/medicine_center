from typing import List, Dict

from fastapi import APIRouter, WebSocket, WebSocketDisconnect
from chat.api.repository import Repository

router = APIRouter()

class ConnectionManager:
    def __init__(self):
        self.active_connections: List[Dict] = []
    roles = ['doctor', 'patient']

    def opposite(self, role):
        return 'doctor' if role=='patient' else 'patient'

    async def connect(self, websocket: WebSocket, role, doctor_id, patient_id):
        await websocket.accept()
        self.active_connections.append({'socket':websocket, 'role':role, 'doctor_id':doctor_id, 'patient_id':patient_id})


    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove([l for l in self.active_connections if l['socket']==websocket][0])
    
    async def send_message(self, message: str, role_receiver, sender_id, receiver_id):
        """
        sends message to all socket connections associated with the chat
        """
        pair = [sender_id, receiver_id]
        receiver_sockets = [l['socket'] for l in self.active_connections 
        if l['doctor_id'] in pair and l['patient_id'] in pair]
        for s in receiver_sockets:
            await s.send_text(message)
        

manager = ConnectionManager()


@router.websocket("/ws/{sender}{doctor_id}{patient_id}")
async def websocket_endpoint(websocket: WebSocket, sender: str, doctor_id:str, patient_id:str):
    await manager.connect(websocket, sender, doctor_id, patient_id)
    try:
        while True:
            data = await websocket.receive_text()
            Repository.save_message(doctor_id, patient_id, sender, data)

            # send message to receiver
            if sender=='doctor':
                manager.send_message(data, receiver_role='patient', sender_id=doctor_id, receiver_id=patient_id)
            else:
                manager.send_message(data, receiver_role='doctor', sender_id=patient_id, receiver_id=doctor_id)

    except WebSocketDisconnect:
        manager.disconnect(websocket)


@router.get('chat/{doctor_id}{patient_id}')
async def get_chat_messages(doctor_id, patient_id):
    """
    Gets messages from a chat between doctor and patient
    :param doctor_id: patient's id
    :param patient_id: doctor's id
    :returns: list of messages
    """
    messages = Repository.get_chat_messages(doctor_id, patient_id)

    return messages