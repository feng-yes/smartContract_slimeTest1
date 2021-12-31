
const SlimeCoin = artifacts.require("SlimeCoin");
const SlimeTPS = artifacts.require("SlimeTokenPrivateSale");


contract("test SlimeCoin", async accounts => {
    it("test 1", async () =>{
        var insCoin = await SlimeCoin.deployed();
        console.log("SlimeCoin address: ", insCoin.address);
        var outCoinBalance = await insCoin.balanceOf(accounts[0]);
        console.log("balanceOf: accounts[0]", outCoinBalance.toString());
        await insCoin.mint(accounts[0], 10999999999);
        var outCoinBalance = await insCoin.balanceOf(accounts[0]);
        console.log("after mint: accounts[0]", outCoinBalance.toString());
        await insCoin.burn(accounts[0], 10999999999);
        var outCoinBalance = await insCoin.balanceOf(accounts[0]);
        console.log("after burn: accounts[0]", outCoinBalance.toString());
        await insCoin.transfer(accounts[1], 888888);
        var outCoinBalance = await insCoin.balanceOf(accounts[0]);
        var outCoinBalance1 = await insCoin.balanceOf(accounts[1]);
        console.log("accounts[0] -> accounts[1]", outCoinBalance.toString(), outCoinBalance1.toString());

        console.log();
        await insCoin.PauseContract();
        var bPause = await insCoin.paused();
        console.log("bPause", bPause);
        // await insCoin.transfer(accounts[1], 888888);  // error case
        await insCoin.StopPauseContract();
        var bPause = await insCoin.paused();
        console.log("bPause", bPause);
        await insCoin.transfer(accounts[1], 888888);
        var outCoinBalance = await insCoin.balanceOf(accounts[0]);
        var outCoinBalance1 = await insCoin.balanceOf(accounts[1]);
        console.log("accounts[0] -> accounts[1]", outCoinBalance.toString(), outCoinBalance1.toString());

        console.log();
        await insCoin.setAdmin(accounts[1]);
        var iNewAdminId = await insCoin.getAdminIDByAdress(accounts[1]);
        console.log("new admin id: ", iNewAdminId.toNumber(), accounts[1]);
        await insCoin.approve(accounts[1], 100000);
        await insCoin.buyCoins({ value: 10000 });
        await insCoin.changeAdminAddress(iNewAdminId.toNumber(), accounts[2]);
        var address = await insCoin.getAdminAdressByID(iNewAdminId.toNumber());
        assert.equal(address.toString(), accounts[2].toString(), "not pass");
    });

});