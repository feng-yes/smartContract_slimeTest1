
var SlimeCoin = artifacts.require("SlimeCoin");
var SlimeTPS = artifacts.require("SlimeTokenPrivateSale");

module.exports = function(deployer) {
    deployer.deploy(SlimeCoin)
        // 等待、直到合约部署完成
        .then(() => SlimeCoin.deployed())
        // 传递 Storage 合约地址，部署 InfoManager 合约
        .then(() => deployer.deploy(SlimeTPS, SlimeCoin.address));
}