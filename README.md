# Flask

Flask is a micro web framework written in Python. It is classified as a microframework because it does not require particular tools or libraries. It has no database abstraction layer, form validation, or any other components where pre-existing third-party libraries provide common functions.
Installation

To install Flask, use pip:

pip install Flask

Usage

Here is a simple example of a Flask app:

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

Save this code in a file named app.py and run it with the following command:

flask run

The app will be available at http://127.0.0.1:5000/.

For more information, check out the Flask documentation.
https://flask.palletsprojects.com/en/2.2.x/
