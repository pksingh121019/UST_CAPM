const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    // Step 1: Get the object of our OData entities
    const { EmployeeSet, POs } = this.entities;

    // ✅ Handle Root URL `/`
    this.on('GET', '/', (req) => {
        return 'Welcome to myfirstapp! OData service is available at <a href="/odata/v4/CatalogueService">/odata/v4/CatalogueService</a>';
    });

    // Validation before UPDATE
    this.before('UPDATE', EmployeeSet, (req) => {
        var salary = parseInt(req.data.salaryAmount);
        if (salary >= 100000) {
            req.error(500, 'Sorry, invalid salary');
        }
    });

    // Add default employee data after READ
    this.after('READ', EmployeeSet, (data) => {
        data.push({
            "ID": "AB001",
            "nmeFisrt": "Munna"
        });
    });

    // Boost PO action
    this.on('boost', async (req, res) => {
        try {
            const ID = req.params[0];
            console.log("Hey Amigo, Your purchase order with id " + ID + " will be boosted");
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=': 20000 }
            }).where(ID);
        } catch (error) {
            return "Error " + error.toString();
        }
    });

    // Get order defaults action
    this.on('getOrderDefaults', async (req, res) => {
        return {
            "OVERALL_STATUS": 'N',
        };
    });

    // Find the largest order
    this.on('largestOrder', async (req, res) => {
        try {
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(5);

            return reply;
        } catch (error) {
            return "Error " + error.toString();
        }
    });
});