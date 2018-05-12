pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;

/*
* Blockchain based document sharing smart contract
*  ____  ____  ____  ____  
* | __ )| __ )|  _ \/ ___| 
* |  _ \|  _ \| | | \___ \ 
* | |_) | |_) | |_| |___) |
* |____/|____/|____/|____/ 
*                          
* Description - Smart contract to handle document access permissions and 
*               create a trust-less document sharing ecosystem
* Smart contract foolprints -
*
* To Add New Document - PushNewDocument
* To Get All User Documents - GetUserDocuments
* To Create Access Request - AddAccessRequest
* To Accept/Denied Request - AccessRequestUpdate
*
*/

contract DocumentTransferContract {

    /**
     * Structure to hold document
     */
    struct Document {
        address issuerAddress;
        address userAddress;
        uint256 documentHash;
        uint256 timestamp;
    }
    
    /**
     * Structure to hold all access requests
     */
    struct AccessRequest {
        address requesterAddress;
        uint256 documentHash;
        bool accepted;
        bool denied;
    }

    /**
    * To hold all documents
    */
    Document[] public Documents;

    /**
    * To hold all access requests
     */
    AccessRequest[] public AccessRequests;

    /**
    * Function to push new document details to Documents array
    * @param _issuerAddress {address} - document issuer wallet address/public key
    * @param _userAddress {address} - wallet address/public key of user to whom document is issued
    * @param _documentHash {uint} - document hash
    */
    function PushNewDocument(address _issuerAddress, address _userAddress, uint256 _documentHash) public returns (uint256) {
        Document memory newDocument;
        newDocument.issuerAddress = _issuerAddress;
        newDocument.userAddress = _userAddress;
        newDocument.documentHash = _documentHash;
        newDocument.timestamp = getCurrentTimestamp();

        Documents.push(newDocument);
    }

    /**
    * Function to get user documetns
    * @param _userAddress {address} - wallet address/public key of user to whom document is issued
    */
    function GetUserDocuments(address _userAddress) public returns (Document[]) {
        uint length = Documents.length;
        Document[] storage userDocuments;

        for (uint i=0; i < length; i++) {
            if (Documents[i].userAddress == _userAddress) {
                userDocuments.push(Documents[i]);
            }
        }

        return userDocuments;
    }

    /**
    * Function to add a new access request
    * @param _requester {address} - wallet address/public key of requester
    */
    function AddAccessRequest(address _requester, uint256 _hash) public {
        AccessRequest memory newAccessRequest;

        newAccessRequest.requesterAddress = _requester;
        newAccessRequest.documentHash = _hash;
        newAccessRequest.accepted = false;
        newAccessRequest.denied = false;

        AccessRequests.push(newAccessRequest);
    }
    
    /**
     * function to accept/denied access request
     * @param _userAddress {address} - document owner address
     * @param _requesterAddress {address} - document requester address
     * @param _hash {uint256} - document hash
     * @param _accept {bool} - if _accept is true then request is accepted
     *                          if _accept is false then request is denied
    */
    function AccessRequestUpdate(address _userAddress, address _requesterAddress, uint256 _hash, bool _accept) public {
        uint length = AccessRequests.length;
        
        address ownerAddress = GetDocumentUserAddress(_hash);
        
        if (_userAddress == ownerAddress) { 
            for (uint i=0; i < length; i++) {
                if (AccessRequests[i].requesterAddress == _requesterAddress && AccessRequests[i].documentHash == _hash) {
                    if (_accept) {
                        AcceptRequest(i);
                    } else {
                        DeniedRequest(i);
                    }
                }
            }   
        }
    }
    
    /**
     * Function to update accept status of AccessRequest
     * @param _index {uint} - index value of access request in AccessRequests array
    */
    function AcceptRequest(uint _index) public {
        AccessRequests[_index].accepted = true;
    }
    
    /**
     * Function to update denied status of AccessRequest
     * @param _index {uint} - index value of access request in AccessRequests array
    */
    function DeniedRequest(uint _index) public {
        AccessRequests[_index].denied = true;
    }
    
    /**
     * function to get user address of specific Documents
     * @param _hash {uint256} - document hash
     * @return {address} - user address
    */
    function GetDocumentUserAddress(uint256 _hash) view public returns (address) {
        uint length = Documents.length;
        address userAddress;
        
        for (uint i=0; i < length; i++) {
            if (Documents[i].documentHash == _hash) {
                userAddress = Documents[i].userAddress;
            }   
        }
        
        return userAddress;
    }

    /**
    * @dev - function to return current timestamp
    */
    function getCurrentTimestamp() view internal returns (uint256) {
        return now;
    }
}