module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!

  solc: {
    version: "node_modules/solc",
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};
