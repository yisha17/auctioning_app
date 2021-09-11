from bid import seller
from flask import Flask,jsonify
from flask_pymongo import PyMongo
from flask_restx import Api


app = Flask(__name__)
app.config['MONGO_URI'] = "mongodb://localhost:27017/bid"
app.config['MONGO_CONNECT'] = True
mongo = PyMongo(app)
api = Api(app)
print (mongo)



from . import routes
from bid.users.autentication import user
from bid.seller.sell_item import seller
from bid.transaction.transaction import trans

app.register_blueprint(routes.main)
app.register_blueprint(user)
app.register_blueprint(seller)
app.register_blueprint(trans)