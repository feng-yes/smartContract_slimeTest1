// const ABCToken = artifacts.require("ABCToken");

// module.exports = function (deployer) {
//   deployer.deploy(ABCToken);
// };

var ABCToken = artifacts.require("ABCToken");
var SlimeNFT = artifacts.require("SlimeNFT");

module.exports = function(deployer) {
    deployer.deploy(ABCToken)
        // 等待、直到合约部署完成
        .then(() => ABCToken.deployed())
        // 传递 Storage 合约地址，部署 InfoManager 合约
        .then(() => deployer.deploy(SlimeNFT, ABCToken.address));
}