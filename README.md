# Vibranium.app
## Let business pay transaction fee for you

One of the friction points for Ethereum dapp adoption is that the users have to pay gas(txn fee) to get their transactions recorded on the blockchain. 

A user who wants to record his/her transaction on the blockchain has to pay a transaction/gas fee. This is not ideal because as a dapp owner, you are expecting your application users to have Ether to pay for gas when all they want to do is perform a simple action which has nothing to do with transferring money. But if the transaction needs to be executed on the blockchain, there is no other option but to pay the fee. What if there was a way for users to execute transactions securely (vote for a candidate in our example) and let someone else (potentially contract owner) record the transaction on the blockchain and pay for it?

This project will setup a queue messaging system where all transaction will be queued. The all transactions are sent with digital signature. 
Transaction will be digitally signed with their private key. Message queue will hold transaction and Digital Signature.
Digital signature will prevent transaction to be tempered through channels.

