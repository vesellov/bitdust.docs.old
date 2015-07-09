# Data Security

* [Brief Summary](#brief-summary)
* [Private Key](#privatdigital key)
* [Public Key](#public-key)
* [Digital signature](#digital-signature)
* [Service Traffic](#service-traffic)
* [Data Transfer](#data-transfer)
* [Encryption](#encryption)
* [Storage](#storage)
* [Data Integrity](#data-integrity)
* [Full Control](#full-control)


## Brief Summary 

* Data encryption algorithm: `DES3`
* Session key size: `24` байта
* Key session encryption algorithm: `RSA`
* Possible RSA key sizes: `1024`, `2048` и `4096` бит
* Hash-function for digital signature: `SHA1`


## Private Key

Data security in BitDust system is based upon crypto-system with an open key. For data encryption and digital signature creation this asymmetric algorithm uses a key consisting of two parts: public key and private key. It is a secret key and only this key protects authenticity and user's personal data.

The private key is created by the first BitDust program start. The original key is stored on the hard disk drive in the folder `.bitdust/metadata/mykeyfile`.

On each start of BitDust program the key will be loaded into the operational memory of the computer and will be used for user data protection. After program stops, this temporary copy of the private key will be automatically deleted during the memory cleaning.


#### ATTENTION!
    It is highly recommended to make several backup copies of the key, record it on different media
    and hide in safe places just after secret key generation. These could be USB-flash card, CD-disk,
    A4 list or encrypted file on another machine.
    Only this secret key gives an access to user data!
    By its loss all your information will be completely lost.!!!
    Never do copies of the key thru open or untrusted channels! 
    The reliability of your personal information security is completely dependent on the private key safety.


## Public Key

The scheme of two-way user authentication in BitDust network is described in the section User Identification.

Public part of user key or, in other words, "open" key is stored in [identity](glossary.md#identity) file which is open for everyone and serves as a kind of user passport. These files can be freely allocated in the Internet and have unique address – IDURL.

Public key is used for encryption of incoming data which need to me transmitted via Internet from remote machine to machine of the user himself. Only with the help of a secret key which is stored only in user’s machine you can decrypt the data.

Thus public key must be forwarded to all the nodes with which you want to maintain a safe connection. For this purposes BitDust program has a functional for distributing identity user files to each other.


## Digital signature

All user identity files are secured with digital signature. 
By creating or changing user identity the generation of an digital signature takes place – it is connected to the file content and serves for security from changes.

Digital signature is calculated due to the file content via Hash-function, for this one needs to have a private user key which is stored only on his machine. Thus only the user himself has a possibility to make changes to the publicly available "passport" and only when having his secret key on hands. 

The general principle of user identity protection from changes is based on the fact that all other nodes check the correspondence between digital signature and file content each time when they receive a new copy of its identity – this standard method in cryptography is called VerifySignature.


## Service Traffic

Digital signature is used not only for protection of user identity file from modifications but also all service data which are forwarded from one node to another in the BitDust network. 

All users exchange so-called "service packages", which include digital signature and are safe from modifications in the process of forwarding in the Internet. This enables data dibbling security as all received packages will be checked for the correspondence of content and digital signature.

Service packages are forwarded in the not encrypted form and still can be marked as signed packages. The structure of a signed package is the following:

* `Command` – BitDust protocol command name
* `OwnerID` – package owner IDURL 
* `CreatorID` – IDURL of the creator, whose key signed the package 
* `PacketID` – package identifier 
* `Date` – creation date and time  
* `Payload` – useful data in source (not encrypted) form 
* `RemoteID` – IDURL of addressee 
* `Signature` – digital signature


## Data Transfer

To hide the data another class of packages is used, it is called "encrypted block".
These data blocks are forwarded inside the service packages and the field `Command` will have a value "Data" – which means that the given package contains encrypted data block.

You can represent this mechanism as two layers where internal encrypted layer is somehow "put" inside the external one – or the service one: 

1. external layer allows forwarding the data which are secured from modifications with digital signature
2. internal layer allows hiding them with the help of encryption

The structure of encrypted block is the following:

* `CreatorID` – IDURL of data block creator
* `BackupID` – data identifier
* `BlockNumber` – block number in the chain
* `SessionKeyType` – algorithm used for encryption
* `EncryptedSessionKey` – encrypted session key
* `Length` – actual length of not encrypted data in that block
* `LastBlock` – last block in the data chain marker
* `EncryptedData` – encrypted useful data
* `Signature` – digital signature


## Encryption

At the moment the encryption of data recorded in the field `EncryptedData` is done by the DES3 algorithm.

This symmetric algorithm uses so-called session key for data perturbation – anyone who knows the key can decrypt them. Session key is generated for each new data block and is used for encryption of only this block. Data security is based on hiding the key itself – it is encrypted with the help of receiver’s public key. As the result to the structure of the encrypted package get not the session key itself but its encrypted copy, which is recorded in the field `EncryptedSessionKey`. Encrypted data are recorded in the field `EncryptedData`.

Thus RSA algorithm encrypts only session key, but the data themselves are secured with DES3 algorithm. Such an approach allows increasing BitDust program performance, as the symmetric method of encryption DES3 works much faster than algorithm RSA. In other words the simple combination of two algorithms is used:

+ symmetric DES3 encryption
+ asymmetric RSA enctryption

We are looking forward to adding a support of AES3 and BlowFish algorithms and give users a chance to choose desired method of symmetric encryption in the program settings.


## Storage

Session key is not available to anyone except for the user himself – he and only he can decrypt the field `EncryptedSessionKey` with the help of the private key and extract the session key. Thus user data which get to supplier’s machine are kept in an encrypted form and they are not available for reading to the supplier.

Supplier receives data portions inside service packages, in the field `Payload`, and records the data completely to different files on his hard disk drive. As a result the encrypted block portion are allocated on the supplier’s node – the field `EncryptedData` is kept the same as it was when created on the machine of data owner.

When user requests his data back from supplier’s machine they are back in the source encrypted form, but again wrapped in the service pack structure for change security. Then the user decrypts field `EncryptedSessionKey` (with his private key) and extracts from there the session key, which then decrypts the source data block from the field `EncryptedData`.


## Data Integrity

The information uploaded in the BitDust network loses its integrity, as each supplier allocates at his machines only encrypted blocks. Nodes storing user data cannot be identified and read in any way. 

One may talk of uploaded in the network data going through the process of "disintegration" – become absolutely useless for everyone except for the data owner himself. Only he having the private key can reassemble them providing having the baseline minimum quantity of fragments in each block.

The given fact allows storing data of any sensitivity level in the BitDust network, as only the owner of data has an access to them. 


# Full Control

In addition to a possibility of storing your data distributed on the remote machines, BitDust project offers another, absolutely unique possibility to have a total control over your distributed space and secure the data from __theft__ or __elimination__.

It is possible to organize the fully secured storage of user data so that they will be absolutely unavailable for anyone apart from the owner. He and only he will have the key to the only existing copy of these data, allocated on the multiple machines in BitDust network. These nodes store only encrypted fragments of the general data array and cannot read them or use them in any way.  

It is provided to delete source files from the user disk drive after data upload in the BitDust network. His private key the user keeps on USB-stick, and local copy of the private key is deleted from computer local disk. BitDust program will be started on the given computer only with the help off this USB-stick and will be reading the secret key by the start and storing it in computer random access memory, not creating a copy on the local disk drive. After launching the program the user extracts USB-stick and hides in a safe place.

Let us suppose that the user has lost physical control over his computer due to its theft, taking away or any other reason. To keep the total control over his data he needs to be sure that computer power source was turned off – in some cases it is easily done.

By doing this you lose the copy of user secret key kept in the random access memory irrevocably. Afterwards the only private key copy is left with the user’s USB-stick and the access to his personal data is possible only to him. The user needs to download BitDust program again on another computer and restore his data, using his secret key.

In addition to portative USB-stick we recommend you to print the private key on a regular A4 paper list and keep it in the safe place. In this case the user provides additional security if the USB-stick is out of order.

The given approach is unique, after uploading personal user data in the BitDust network and deleting original data from the local hard disk drive of the computer no physical integral copy of the data exists. Data stored distributed on remote computers are just fragments of source data and are useful taken separately – they undergo a process of "disintegration". 
Restoring the source user data is possible only with the help of the private key which is kept on user’s USB-stick or possibly on additional media. 

This approach enables practically the same common mode of operations with data, which are usually stored at a cloud server, for example, but gives a significantly higher level of control over them. As data stored at cloud servers are under control of service suppliers. They can be encrypted by the user before they are put on the cloud server. Still the data are stored in data centers in an integrated form and can be read (if they are not encrypted), deleted or taken away without notice.


[table of contents](toc.md)