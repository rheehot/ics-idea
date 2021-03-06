// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 < 0.7.0;

// 1번 명령에 대한 컨트랙트
contract Command_1 {
    
    // 명령 3번의 점수
    uint public cmdScore = 5;

     // Emp 컨트랙트 객체 생성
    Emp public _emp = new Emp(); 

    // 검증에 사용 할 변수
    uint public sumOfVerifyingScore = 0;

    // 검증 여부를 알려줌
    bool public isVerified = false;
    
    constructor() public {    
        issueCmd_1(3); // 3번 emp가 실행
    }

    function issueCmd_1(uint _empNum) payable public {
        
        _emp.setIssuingEmp(_empNum-1);        
    }

    function verify(uint _numOfVerifyingGroup) public payable returns (bool) {
        // 검증 그룹 점수의 합 초기화
        sumOfVerifyingScore += _emp.getEmpScore(_numOfVerifyingGroup);
        
        if(sumOfVerifyingScore >= cmdScore) {
            isVerified = true;
        }

        return isVerified;
    }
}

// 직원 정보 관리 컨트랙트
contract Emp {
    constructor() public {  
        setEmp();
    }

     // 직원들의 정보를 담을 구조체
    struct employee {
        uint empNum;
        string empName;
        uint empScore;
        uint empTrustScore;
    }

    // 직원 정보들의 array
    employee[] public employees;

    // 직원 정보 입력하기 - test data
    function setEmp() public returns (uint) {
        employees.push(employee(employees.length+1, "사원1", 1, 0));
        employees.push(employee(employees.length+1, "사원2", 2, 1));
        employees.push(employee(employees.length+1, "대리1", 2, 2));
        employees.push(employee(employees.length+1, "대리2", 3, 2));
        employees.push(employee(employees.length+1, "차장1", 3, 3));
        employees.push(employee(employees.length+1, "차장2", 4, 3));
        employees.push(employee(employees.length+1, "과장", 5, 3));
        employees.push(employee(employees.length+1, "팀장", 6, 5));
        employees.push(employee(employees.length+1, "부사장", 7, 4));
        employees.push(employee(employees.length+1, "사장", 9, 8));

        return employees.length;
    }
    
    // 명령 내린 직원의 점수를 0으로 바꾸는 함수
    function setIssuingEmp(uint _issuingCmdEmpNum) public {
        employees[_issuingCmdEmpNum].empScore = 0;
        employees[_issuingCmdEmpNum].empTrustScore = 0;
    }

    // 파라미터로 넘겨준 번호에 해당하는 직원의 점수를 가져오는 함수
    function getEmpScore(uint _empNum) public view returns(uint) {
        return employees[_empNum].empScore;
    }    
}