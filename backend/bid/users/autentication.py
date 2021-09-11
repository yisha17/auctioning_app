from flask import Blueprint,request,jsonify
from pymongo.message import delete
from bid import mongo
from bson.objectid import ObjectId

user = Blueprint('user',__name__)

@user.route('/auction/auth/user',methods=['GET'])
def get_all_users():
    users = mongo.db.users
    output = []
    for q in users.find():
        id = str(ObjectId(q['_id']))
        output.append({'name':q['username'],'email':q['email'],'id':id,'administrator':q['administrator']})

    print(users)

    return jsonify(output)

@user.route('/auction/auth/user/<id>',methods=['GET'])
def get_profile(id):
    users = mongo.db.users

    user =  users.find_one({'_id':ObjectId(id)})

    output = {
            "id":id,
            'name':user['username'],
            'email':user['email'],
            'password':user['password']
        }

    return jsonify(output)    


@user.route('/auction/auth/user',methods=['POST'])
def signup():
    user = mongo.db.users
    name = request.json['username']
    email = request.json['email']
    password = request.json['password']
    confirm_password = request.json['re_password']
   
    if len(password) < 6:
        return jsonify({'result':"password is too short"})
    elif password != confirm_password:
        return jsonify({'result':"password does not match"})
    elif user.find_one({'email':email}) != None:
        return jsonify({'result':"email is already in use"},401)    
    else:
        user_id = user.insert({
            'username':name,
            'email':email,
            'password':password,
            'administrator':False
            })
        new_user = user.find_one({'_id':user_id}) 
        id = new_user['_id']
        
        output = {
            "id":str(id),
            'name':new_user['username'],
            'email':new_user['email'],
            'password':new_user['password']
            }
        print(output)   
        return jsonify(output)

@user.route('/auction/auth/user/<id>',methods=['PUT'])
def update_user(id):
    
    name = request.json['username']
    email = request.json['email']
    password = request.json['password']
    confirm_password = request.json['re_password']

    if len(password) < 6:
        return jsonify({'result':"password is too short"})
    elif password != confirm_password:
        return jsonify({'result':"password does not match"})   
    else:
        
        
        update_user= mongo.db.users.update_one({'_id':ObjectId(id)},{"$set":{
            'username':name,
            'email':email,
            'password':password,
            'administrator':False
            }})

        print(update_user)    
        
      
        return jsonify({'result':"updated"},)


@user.route('/auction/auth/user/<id>',methods=['DELETE'])
def delete_user(id):
    
    users = mongo.db.users
    delete_user = users.find_one({'_id':ObjectId(id)})
    print(delete_user)
    users.delete_one(delete_user)

    return jsonify({'result':"deleted"})

@user.route('/auction/auth/user/login',methods=['POST'])
def login_user():
    users = mongo.db.users 

    
    email = request.json['email'] 
    password = request.json['password']
    user = users.find_one({'email':email,'password':password})
    if user is None:
        print("there is nothing n here")
        return jsonify({'result':"incorrect password or email"},400)
    else:
        id = ObjectId(user['_id'])
        output = {
        "id":str(id),
        'name':user['username'],
        'email':user['email'],
        'password':user['password'],
        'administrator':user['administrator']
    } 
    print(output)
    return jsonify(output)

    

    

    
    





