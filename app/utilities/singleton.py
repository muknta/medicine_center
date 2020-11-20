from threading import RLock


class Singleton(type):
    _instances = {}
    _lock = RLock()

    def __call__(cls, *args, **kwargs):
        if cls not in Singleton._instances:
            with Singleton._lock:
                if cls not in Singleton._instances:
                    Singleton._instances[cls] = super().__call__(
                        *args, **kwargs)
        return Singleton._instances[cls]
