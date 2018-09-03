const EthereumTx = require('ethereumjs-tx');
const EthereumUtils = require('ethereumjs-util');

const offeset = parseInt(process.argv[2]);
const rawTx = {
    nonce: 0,
    gasPrice: 100000000000,
    gasLimit: 800000,
    value: 0,
    data: undefined,
    v: 27,
    r: '0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959
F2815B16F81798',
    s: '0x0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaa'
};

for (let i = 0; i < 16; i++) {
  const code = '0x' + require(`./tmp/${i}/artifacts/ERC820Registry.json`).compilerOutput.evm.bytecode.object;
  rawTx.data = code
  const tx = new EthereumTx(rawTx);
  const contractAddr = EthereumUtils.toChecksumAddress(
    '0x' + EthereumUtils.generateAddress('0x' + tx.getSenderAddress().toString('hex'), 0 ).toString('hex')
  );
  if (contractAddr.startsWith('0x820')) {
    console.log(`${offeset + i} -> ${contractAddr}`);
  }
}
