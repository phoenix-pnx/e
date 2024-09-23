const ICanHasCheezburgerToken = artifacts.require("GeoNexusToken")

contract("GeoNexusToken", (accounts) => {
  before(async () => {
      GNTToken = await GeoNexusToken.deployed()
      console.log(`Address: ${GNTToken.address}`)
  })

  it('the token cap should be 100 million tokens', async () => {
    let cap = await GNTToken.cap()
    cap = web3.utils.fromWei(cap,'ether')
    assert.equal(cap, 100000000, 'The token cap should be 100 million')
  })

  it('gives the owner of the contract 69 million tokens', async () => {
    let balance = await GNTToken.balanceOf(accounts[0])
    balance = web3.utils.fromWei(balance,'ether')
    assert.equal(balance, 69000000, 'Balance of contract creator account should be sixty nine million')
  })

  it('total supply updated after contract creation & transfer to owner', async () => {
    let uncirculatedSupply = await GNTToken.totalSupply()
    uncirculatedSupply = web3.utils.fromWei(uncirculatedSupply,'ether')
    assert.equal(uncirculatedSupply, 69000000, 'Total supply should now be sixty nine million')
  })

  it('can transfer tokens between accounts', async () => {
    let amount = web3.utils.toWei('1000','ether')
    await GNTToken.transfer(accounts[1], amount, {from: accounts[0]})

    let balance = await GNTToken.balanceOf(accounts[1])
    balance = web3.utils.fromWei(balance,'ether')
    assert.equal(balance, 1000, 'Balance of recipient account should be one thousand')
  })

  it('owner can set block reward', async () => {
    await GNTToken.setBlockReward(50)
    let blockReward = await iCHCToken.getBlockReward()
    blockReward = web3.utils.fromWei(blockReward,'ether')
    assert.equal(blockReward, 50, 'Block reward should be fifty')
  });
})