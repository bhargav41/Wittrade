const mongoose =  require('mongoose');

const productSchema = mongoose.Schema({
    _id:mongoose.Schema.Types.ObjectId,
    name:{ type: String, required: true},
    price:{ type: Number, required: true},
    productImage:{type:String,required :true},
    title:{type:String,required:false},
    description:{type:String,required:true},
    sellerContact:{type:String,required:true}
});


module.exports = mongoose.model('Product', productSchema);