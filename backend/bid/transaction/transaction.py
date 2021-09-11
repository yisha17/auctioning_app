from bson.objectid import ObjectId
from flask import Blueprint,request,jsonify
from bid import mongo
trans = Blueprint('tansaction',__name__)


@trans.route('/auction/v1/transaction',methods=['POST'])
def bid_for_item():
    process = mongo.db.bid

    item = request.json['item_name']
    bidder = request.json['user']
    price = request.json['price']
    image = request.json['image']
    
    bid = process.insert({
        'item':item,
        'bidder':bidder,
        'price':price,
        'image':image,
        'winner':False
    })

    buyer = process.find_one({'_id':bid})
    id = buyer['_id']
    output = {
        'id':str(id),
        'item':buyer['item'],
        'bidder':buyer['bidder'],
        'price':buyer['price'],
        'image':buyer['image'],
        'winner':buyer['winner'],
    }
    return jsonify(output)

@trans.route('/auction/v1/transaction/<bidder>',methods=['GET'])
def user_bidded_items(bidder):
    process = mongo.db.bid
    output = []
    event = process.find({"bidder":bidder})
    for q in event:
        id = q['_id']
        output.append({
            'id':str(id),
            'item':q['item'],
            'price':q['price'],
            'image':q['image'],
            'winner':q['winner'],
        })
    return jsonify(output)

@trans.route('/auction/v1/transaction/<id>',methods=['DELETE'])
def delete_bid():
    process = mongo.db.bid
    delete_item = process.find_one({'_id':ObjectId(id)})
    if delete_item != None:
        process.delete_one(delete_item)
        return  jsonify({'result':"deleted"},204)
    return jsonify({"cant get the item",404})

@trans.route('/auction/v1/transaction/<id>',methods=['PUT'])
def update_price(id):
    process = mongo.db.bid
    price = request.json['price']

    event = process.update_one({'_id':ObjectId(id)},{
        "$set":{
            'price':price
        }
    })

    updated_event = process.find_one('_id',event)
    id = updated_event['id']

    output = {
        
        'id':str(id),
        'item':updated_event['item'],
        'bidder':updated_event['bidder'],
        'price':updated_event['price'],
        'image':updated_event['image'],
        'winner':updated_event['winner'],
    
    }

    return jsonify(output)
    
    
