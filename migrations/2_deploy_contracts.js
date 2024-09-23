const GeoNexusToken = artifacts.require("GeoNexusToken");

module.exports = function(deployer) {
  // one hundred million coins
  deployer.deploy(GeoNexusToken, 100000000, 25);
};