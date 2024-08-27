// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract StudentDataOwnership {
    // Mapping of students to their data
    mapping (address => StudentData) public studentData;

    // Struct to represent student data
    struct StudentData {
        string name;
        uint256 grade;
        string institution;
        bool ownershipTransferred;
    }

    // Event emitted when ownership is transferred
    event OwnershipTransferred(address student, address newOwner);

    // Function to set student data
    function setStudentData(string memory _name, uint256 _grade, string memory _institution) public {
        studentData[msg.sender] = StudentData(_name, _grade, _institution, false);
    }

    // Function to transfer ownership
    function transferOwnership(address _newOwner) public {
        require(!studentData[msg.sender].ownershipTransferred, "Ownership already transferred");
        studentData[msg.sender].ownershipTransferred = true;
        emit OwnershipTransferred(msg.sender, _newOwner);
    }

    // Function to get student data
    function getStudentData(address _student) public view returns (string memory, uint256, string memory) {
        return (studentData[_student].name, studentData[_student].grade, studentData[_student].institution);
    }
}

