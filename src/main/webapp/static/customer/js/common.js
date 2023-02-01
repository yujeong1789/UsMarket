/**
 * 
 */

function isEmpty(value) {
	if (value == "" || value == null || value == undefined || (value != null && typeof value == "object" && !Object.keys(value).length)) {
		return true;
	} else {
		return false;
	}
}

// 10보다 작은 값에 0을 붙임 (1월 -> 01월)
function leftPad(value) {
	if (value>=10){
		return value
	}
	return '0'+value;
}

// 현재 시간을 리턴
function getCurrentDate() {
	var d = new Date();
	return (d.getFullYear().toString().slice(2)) + leftPad(d.getMonth()+1) + leftPad(d.getDate()) + leftPad(d.getHours()) + leftPad(d.getMinutes()) + d.getSeconds() + d.getMilliseconds();
}

// 특정 길이의 랜덤한 문자열을 반환하는 함수
const generateRandomString = (num) => {
	const characters ='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	let result = '';
	const charactersLength = characters.length;
	
	for (let i = 0; i < num; i++) {
		result += characters.charAt(Math.floor(Math.random() * charactersLength));
	}

	return result;
}

function getOrderNo(num){
	var d = new Date();
	return d.getFullYear() + leftPad(d.getMonth()+1) + leftPad(d.getDate()) + generateRandomString(num);
}
