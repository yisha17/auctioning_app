from bson.objectid import ObjectId
from flask import Blueprint,request,jsonify,json
from pymongo.message import delete, update
from bid import api,mongo
from flask_restx import Resource

seller = Blueprint('seller',__name__)


@seller.route('/auction/v1/seller/check/<id>',methods=['GET'])
def single_item(id):
    sell = mongo.db.sell
    get_user = sell.find_one({'_id':ObjectId(id)})
    
    output = {
        "id":str(id),
        'item':get_user['item'],
        'user':get_user['user'],
        'increment':get_user['increment'],
        'closing_date':get_user['closing_date'],
        'closing_hour':get_user['closing_hour'],
        'minimum_price':get_user['minimum_price'],
        'image':get_user['image'],
        'closed':get_user['closed'], 
    }
    

    return jsonify(output)
@seller.route('/auction/v1/seller',methods=['POST'])
def post_item():
    sell = mongo.db.sell
    
    
    item_name = request.json['item_name']
    increment =  request.json['increment']
    seller = request.json['user']
    closingDate = request.json['closing_date']
    closingHour = request.json['closing_hour']
    category = request.json['category']
    minimumPrice = request.json['minimum_price']
    image = request.json['image']
    closed = request.json['closed']
    

   
    item = sell.insert({
    'user':seller,
    'item':item_name,
    'increment':increment,
    'closing_date':closingDate,
    'closing_hour':closingHour,
    'category':category,
    'minimum_price':minimumPrice,
    'image':image,
    'closed':closed,
    })
    
    
    
    

    new_sell = sell.find_one({'_id':item})
    print(new_sell)
    id =new_sell['_id']
    output = {

        "item_id":str(id),
        "item":new_sell['item'],
        "user_id":new_sell['user'],
        "increment":new_sell['increment'],
        'closing_date':new_sell['closing_date'],
        'closing_hour':new_sell['closing_hour'],
        'minimum_price':new_sell['minimum_price'],
        'image':new_sell['image']
    }
    
    return jsonify(output)
@seller.route('/auction/v1/seller',methods=['GET'])
def get_all_item():
    sell = mongo.db.sell 
    output = []
    for q in sell.find():
        id = str(ObjectId(q['_id']))
        output.append(
            {'item_id':id,
            'item_name':q['item'],
            'user':q['user'],
            'increment':q['increment'],
            'image':q['image'],
            'category':q['category'],
            'closing_date':q['closing_date'],
            'closing_hour':q['closing_hour'],
            'minimum_price':q['minimum_price'],
            })

    return jsonify(output)
@seller.route('/auction/v1/seller/<string:category>')
def get_based_on_category(category):
    sell = mongo.db.sell 
    items = sell.find({"category":category})
    output = []
    for q in items:
        id = q['_id']
        output.append({
            'item_id':str(id),
            'item_name':q['item'],
            'user':q['user'],
            'increment':q['increment'],
            'category':q['category'],
            'image':q['image'],
            'closing_date':q['closing_date'],
            'closing_hour':q['closing_hour'],
            'minimum_price':q['minimum_price'],
        })
        print(output)
    return jsonify(output)

@seller.route('/auction/v1/seller/<string:user>')
def get_user_item(user):
    sell = mongo.db.sell 

    items = sell.find({"user":user})
    output = []
    for q in items:
        id = q['_id']
        output.append({
            'item_id':str(id),
            'item_name':q['item'],
            'user':q['user'],
            'increment':q['increment'],
            'category':q['category'],
            'image':q['image'],
            'closing_date':q['closing_date'],
            'closing_hour':q['closing_hour'],
            'minimum_price':q['minimum_price'],
        })
        print(output)
    return jsonify(output)


@seller.route('/auction/v1/seller/<string:id>',methods=['DELETE'])  
def delete_item(id):
    sell = mongo.db.sell 

    delete_item = sell.find_one({'_id':ObjectId(id)})
    if delete_item != None:
        sell.delete_one(delete_item)
        return  jsonify({'result':"deleted"},204)
    return jsonify({"cant get the item",404})

@seller.route('/auction/v1/seller/<string:id>',methods=['PUT'])
def update_item(id):

    sell = mongo.db.sell
    seller = request.json['user']
    item_name = request.json['item_name']
    increment =  request.json['increment']
    closingDate = request.json['date']
    closingHour = request.json['hour']
    minimumPrice = request.json['minPrice']
    image = request.json['image']


    item = sell.update_one({'_id':ObjectId(id)},{"$set":{
        'user':seller,
        'item_name':item_name,
        'increment':increment,
        'closing_date':closingDate,
        'closing_hour':closingHour,
        'minimum_price':minimumPrice,
        'image':image,
    }})

    updated_item = sell.find_one('_id',item)
    id = updated_item['id']

    output = {
        "id":str(id),
        'item_name':updated_item['item_name'],
        'user':updated_item['user'],
        'increment':updated_item['increment'],
        'closing_date':updated_item['closing_date'],
        'closing_hour':updated_item['closing_hour'],
        'minimum_price':updated_item['minimum_price'],
        'image':updated_item['image']

    }
    return jsonify(output)












