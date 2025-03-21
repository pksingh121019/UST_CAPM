module.exports = async (srv) => {

    srv.on('welcome', (req,res)=>{
        return "Hello !" + req.data.name ;
    })
}