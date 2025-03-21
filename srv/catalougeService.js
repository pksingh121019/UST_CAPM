module.exports = cds.service.impl( async function(){

  //Step 1: get the object of our odata entities
  const { EmployeeSet, POs } = this.entities;

//Action -when,what,which 
//when- on,before,after
//example--no emp can have salary 1-lakh rs.
      this.before('UPDATE', EmployeeSet,(req) => {

        var salary = parseInt(req.data.salaryAmount);
        if (salary >= 100000) {
            req.error(500,'sorry invalid salary');
        }
      }

      );
      this.after( 'READ',EmployeeSet,(data) => {
          data.push({
            "ID": "AB001",
            "nmeFisrt" : "Munna"
          });
      }

      );
 
  this.on('boost', async (req,res) => {
      try {
        //get the PO key since this is  instance based action
          const ID = req.params[0];
          //just print the console for our understanding
          console.log("Hey Amigo, Your purchase order with id " + req.params[0] + " will be boosted");
         //start a db transaction using CDS ql
          const tx = cds.tx(req);
          //update the gross amount 
          await tx.update(POs).with({
              GROSS_AMOUNT: { '+=' : 20000 }
              //NOTE: 'Boosted!!'
          }).where(ID);
      } catch (error) {
          return "Error " + error.toString();
      }
  });

  this.on('getOrderDefaults', async (req,res) => {
     return {
        "OVERALL_STATUS": 'N',

     }

  });
  this.on('largestOrder', async (req,res) => {
    try {
        //const ID = req.params[0];
        const tx = cds.tx(req);
        
        //SELECT * UPTO 1 ROW FROM dbtab ORDER BY GROSS_AMOUNT desc
        const reply = await tx.read(POs).orderBy({
            GROSS_AMOUNT: 'desc'
        }).limit(5);

        return reply;
    } catch (error) {
        return "Error " + error.toString();
    }
});

}
);