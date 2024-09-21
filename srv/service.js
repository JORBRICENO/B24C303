const cds = require('@sap/cds');

module.exports = class LogaliGroup extends cds.ApplicationService {

    init () {
        
        const {ProductSet, InventorySet} = this.entities;

        //before
        //on
        //after

        this.before('NEW', ProductSet.drafts, (req)=>{
            req.data.detail??= {
                baseUnit: "EA",
                heigth: 0.00,
                width: 0.00,
                depth: 0.00,
                weight: 0.00,
                unitVolume: "CM",
                unitWeight: "KG"
            }
        });

        this.before('NEW', InventorySet.drafts, async (req)=>{
            const oSearch = await SELECT.one.from(InventorySet.drafts).columns(`max(stockNumber) as Max`).where({product_ID: req.data.product_ID });
            req.data.stockNumber = oSearch.Max + 1;
        });

        return super.init();
    }


};