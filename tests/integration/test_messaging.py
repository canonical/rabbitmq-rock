import pika

RABBITMQ_HOST = 'localhost'
QUEUE_NAME = 'test_queue'
RABBITMQ_USER = 'guest'
RABBITMQ_PASSWORD = 'guest'

def send_message():
    credentials = pika.PlainCredentials(RABBITMQ_USER, RABBITMQ_PASSWORD)
    connection = pika.BlockingConnection(pika.ConnectionParameters(
        host=RABBITMQ_HOST,
        credentials=credentials
    ))
    channel = connection.channel()

    channel.queue_declare(queue=QUEUE_NAME)

    message = 'Hello, RabbitMQ!'
    channel.basic_publish(exchange='',
                          routing_key=QUEUE_NAME,
                          body=message)
    print(f" [x] Sent '{message}'")

    connection.close()

def receive_message():
    credentials = pika.PlainCredentials(RABBITMQ_USER, RABBITMQ_PASSWORD)
    connection = pika.BlockingConnection(pika.ConnectionParameters(
        host=RABBITMQ_HOST,
        credentials=credentials
    ))
    channel = connection.channel()

    channel.queue_declare(queue=QUEUE_NAME)

    def callback(ch, method, properties, body):
        print(f" [x] Received {body.decode()}")
        connection.close()

    channel.basic_consume(queue=QUEUE_NAME,
                          on_message_callback=callback,
                          auto_ack=True)

    print(' [*] Waiting for messages. To exit press CTRL+C')
    channel.start_consuming()

if __name__ == "__main__":
    import threading
    consumer_thread = threading.Thread(target=receive_message)
    consumer_thread.start()

    send_message()

    consumer_thread.join()
