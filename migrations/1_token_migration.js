
var SlimeCoin = artifacts.require("SlimeCoin");
var SlimeNFT = artifacts.require("SlimeNFT");

module.exports = function(deployer) {
    deployer.deploy(SlimeCoin)
        // 等待、直到合约部署完成
        .then(() => SlimeCoin.deployed())
        // 传递 Storage 合约地址，部署 InfoManager 合约
        .then(() => deployer.deploy(SlimeNFT, SlimeCoin.address));
}