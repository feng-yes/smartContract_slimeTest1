
var SlimeCoin = artifacts.require("SlimeCoin");
var SlimeTPS = artifacts.require("SlimeTokenPrivateSale");


contract("test SlimeCoin", async accounts => {
    it("test 1", async () =>{
        const insCoin = await SlimeCoin.deployed();
        var outCoinBalance = await insCoin.balanceOf.call(accounts[0]);
        console.log("balanceOf: accounts[0]", outCoinBalance.toString());
        var iNewAdminId = await insCoin.setAdmin.call(accounts[1]);
        console.log("new admin id: ", iNewAdminId.toNumber(), accounts[1]);
        // console.log(typeof(accounts[1]), typeof(accounts[1].toString()));
        var iLen = await insCoin.checkAdminLen.call();
        console.log("admin len: ", iLen.toNumber());
        await insCoin.changeAdminAddress.call(iNewAdminId.toNumber(), accounts[2]);
        var address = await insCoin.getAdminAdressByID.call(iNewAdminId.toNumber());
        assert.equal(address.toString(), accounts[2].toString(), "not pass");
    
        // return SlimeCoin.deployed()
        //   .then(instance => {
        //     slimeCoinIns = instance;
        //     return slimeCoinIns.balanceOf.call(accounts[0]);
        //   })
        //   .then(outCoinBalance => {
        //     let metaCoinBalance = outCoinBalance.toString();
        //     console.log("balanceOf: accounts[0]", metaCoinBalance);
        //   })
        //   .then(() => {
        //     return slimeCoinIns.changeAdminAddress(1, accounts[0]);
        //   })
        //   .then(() => {
        //     return slimeCoinIns.changeAdminAddress(1, accounts[0]);
        //   })
        //   .then(bRes => {
        //     assert.equal(
        //       bRes,
        //       true,
        //       "not true"
        //     );
        // });
    });

});