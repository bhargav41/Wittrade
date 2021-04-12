const mongoose = require('mongoose');
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const User = require('../models/user');

exports.user_profile = (req,res,next)=>{
    User.find().select('name phoneNumber _Id email').exec().then(docs =>{
        const response = {
            users: docs.map(doc => {
                return {
                    name: doc.name,
                    phoneNumber:doc.phoneNumber,
                    email:doc.email,
                    _id : doc._id,
                    request:{
                        type : 'GET',
                        url: 'http://localhost:3000/user/profile/'+doc._id
                    }
                }
            })
        }
         // if(doc.length >= 0){
         res.status(200).json(response);
     })
         .catch(err => {
             console.log(err);
             res.status(500).json({
                 error: err
             });
         });
 }

 exports.user_get_profile = (req, res, next) => {
    const token = req.headers.authorization.split(" ")[1];
    const decoded = jwt.verify(token,"secret");
    const id = decoded.userID;
    User.findById(id)
        .select('name phoneNumber _id email').exec()
        .then(doc => {
            console.log(doc);
            if (doc) {
                res.status(200).json({
                  profile: doc,
                  request: {
                      type:'GET',
                      url:"http://localhost:3000/profile"
                  }
                });
            } 
            else {
                res.status(404).json({ message: 'No valid entry found for provided ID' });
            }
        
})
        .catch(err => {
            console.log(err);
            res.status(500).json({ error: err });
        });
}

exports.user_signup= (req, res, next) => {
    User.find({email:req.body.email}).exec().then(user =>{
        if(user.length >= 1){
            return res.status(409).json({
                message:'Mail exists'
            })

        }
        else{
          bcrypt.hash(req.body.password, 10, (err, hash) => {
              if (err) {
                  return res.status(500).json({
                      error: err
                  });
              } else {
                  const user = new User({
                      _id: new mongoose.Types.ObjectId(),
                      name:req.body.name,
                      phoneNumber:req.body.phoneNumber,
                      email: req.body.email,
                      password: hash,
                  });
                  user.save()
                  .then(result =>{
                      console.log(result)
                          const token= jwt.sign({
                            email:req.body.email,
                            userID: new mongoose.Types.ObjectId(),
                        },
                       "secret",
                        {
                            expiresIn: "10000000020000h"
                        })
                        return res.status(200).json({
                            message:"User created",
                            token:token
                        });
                      })
                  .catch(err =>{
                      console.log(err)
                      return res.status(500).json({
                          error: err
                      });
          });
              }
      });
        }
    })
  
}

exports.user_login =(req,res,next)=>{
    User.find({email:req.body.email}).exec()
    .then(user => {
        if(user.length <1){
            return res.status(401).json({
                message:'Auth failed'
            });  
        }
        bcrypt.compare(req.body.password,user[0].password,(error,result)=>{
            if(error){
                return res.status(401).json({
                    message:'Auth failed'
                });  
            }
            if(result){
              const token= jwt.sign({
                    email:user[0].email,
                    userID: user[0]._id
                },
               "secret",
                {
                    expiresIn: "10000000000000002h"
                })
                return res.status(200).json({
                    message:'Auth successful',
                    token:token
                });
            }
            res.status(401).json({
                message:'Auth failed'
            });  
        })
    })
    .catch(err =>{
        console.log(err)
         res.status(500).json({
            error: err
        });
    })
}

exports.user_delete = (req,res,next )=>{
    User.remove({_id:req.params.userId}).exec()
    .then(result =>{
        res.status(200).json({
            message:'User Deleted'
        });
    }).catch(err =>{
            console.log(err)
             res.status(500).json({
                error: err
            });
        

})

  }

