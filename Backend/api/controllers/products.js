const Product = require('../models/product');
const mongoose = require('mongoose');
const UserController = require('./user');
const user = require('../models/user');
const jwt = require('jsonwebtoken')


exports.products_get_all =  (req, res, next) => {
   
     Product.find().exec().then(docs => {
 
       const response = {
           count: docs.length,
           products: docs.map(doc => {
               return {
                   name: doc.name,
                   price:doc.price,
                   productImage:doc.productImage,
                   title:doc.title,
                   description:doc.description,
                   sellerContact: doc.sellerContact,
                   _id : doc._id,
                   request:{
                       type : 'GET',
                       url: 'http://localhost:3000/products/'+doc._id
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

exports.products_create_product = async (req, res, next) => {
    const token = req.headers.authorization.split(" ")[1];
    const decoded = jwt.verify(token,"secret");
    const userID = decoded.userID;
    const userDoc =  await user.findById(userID)
    const product = new Product({
        _id: new mongoose.Types.ObjectId(),
        name: req.body.name,
        price: req.body.price,
        productImage:req.file.path,
        title:req.body.title,
        description:req.body.description,
        sellerContact: userDoc.phoneNumber
    })
    product.save().then(result => {
        console.log(result);
        res.status(201).json({
            createdProduct:{
                name: result.name,
                price:result.price,
                title:result.title,
                description:result.description,
                sellerContact: result.sellerContact,
                _id : result._id,
                request:{
                    type:'GET',
                    url:'http://localhost:3000/products/'+result._id
                }
            } 
        });
    })
        .catch(err => {
        console.log(err);
        res.status(500).json({
        error:err
        });
});
}

exports.products_get_product = (req, res, next) => {
    const id = req.params.productId;
    Product.findById(id)
        .select('name price _id productImage title description sellerContact').exec()
        .then(doc => {
            console.log(doc);
            if (doc) {
                res.status(200).json({
                  product: doc,
                  request: {
                      type:'GET',
                      url:"http://localhost:3000/products"
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

exports.products_update_product =  (req, res, next) => {
    const id = req.params.productId;
    const updateOps = {};
    for (const ops in req.body) {
        updateOps[ops.propName] = ops.value;
    }
    Product.update({ _id: id }, {
        $set: updateOps
    }).exec().then(result => {
        // console.log(result);
        res.status(200).json({
            message:'Product updated',
            request:{
                type:'GET',
                url:'http://localhost:3000/products/'+id
            }
        });
    }).catch(err => {
        console.log(err);
        res.status(400).json({ error: err });
    });
}
exports.products_delete = (req, res, next) => {
    const id = req.params.productId;
    Product.remove({ _id: id }).exec().then(result => {
        res.status(200).json({
            message:'Product deleted',
            request:{
                    typr:'POST',
                    url:"http://localhost:3000/products",
                    body: {name: 'String', price: 'Number'}
            }
        });
    }).catch(err => {
        console.log(err);
        res.status(500).json({ error: err });
    });
}