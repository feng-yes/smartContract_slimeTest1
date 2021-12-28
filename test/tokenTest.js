
var SlimeCoin = artifacts.require("SlimeCoin");


contract("SlimeCoin", accounts => {
    it("test 1", () =>{
        let slimeCoinIns;
    
        return SlimeCoin.deployed()
          .then(instance => {
            slimeCoinIns = instance;
            return slimeCoinIns.balanceOf.call(accounts[0]);
          })
          .then(outCoinBalance => {
            let metaCoinBalance = outCoinBalance.toString();
            console.log("balanceOf: accounts[0]", metaCoinBalance);
          })
          .then(() => {
            return slimeCoinIns.changeAdminAddress(1, accounts[0]);
          })
          .then(() => {
            return slimeCoinIns.changeAdminAddress(1, accounts[0]);
          })
          .then(bRes => {
            assert.equal(
              bRes,
              true,
              "not true"
            );
        });
    });

});