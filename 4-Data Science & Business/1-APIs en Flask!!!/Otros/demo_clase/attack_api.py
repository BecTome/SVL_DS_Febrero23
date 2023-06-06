
import requests

root_path = "http://127.0.0.1:5000"
def send_request(path, content=None):
    url = root_path + path
    response = requests.get(url, json=content)

    print("Status code:", response.status_code)
    print("Headers", response.headers)
    print("Content:", response.text)
    print("Type content:", type(response.text))
    print("Content json:", response.json())

# Ejemplo para todos los libros
send_request("/api/v1/resources/books")

# Ejemplo para buscar por id en body
send_request("/api/v1/resources/book/Connie Willis")

# Query de datos en el body
send_request("/api/v1/resources/book", {"id": "1"})
