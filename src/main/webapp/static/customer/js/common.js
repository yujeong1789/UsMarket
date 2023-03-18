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

// 시간 반환하는 함수
let convert = function(createdAt) {
  	const milliSeconds = new Date() - new Date(createdAt)
  	const seconds = milliSeconds / 1000
  
	if (seconds < 60) return `방금 전`
	const minutes = seconds / 60
	if (minutes < 60) return `${Math.floor(minutes)}분 전`
	const hours = minutes / 60
	if (hours < 24) return `${Math.floor(hours)}시간 전`
	const days = hours / 24
	if (days < 7) return `${Math.floor(days)}일 전`
	const weeks = days / 7
	if (weeks < 5) return `${Math.floor(weeks)}주 전`
	const months = days / 30
	if (months < 12) return `${Math.floor(months)}개월 전`
	const years = days / 365
	return `${Math.floor(years)}년 전`
};

let msToTime = function(createdAt){
	let milliSeconds = new Date(createdAt);
	
	return `${leftPad(milliSeconds.getHours())}:${leftPad(milliSeconds.getMinutes())}`;
};

let msToDate = function(createdAt){
	let milliSeconds = new Date(createdAt);
	
	return `${milliSeconds.getFullYear()}/${leftPad(milliSeconds.getMonth()+1)}/${leftPad(milliSeconds.getDate())}` 
};

let getFormData = function(form){
	return Object.fromEntries(new FormData(form).entries());
};

let getFileSize = function(filesize) {
    var text = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var e = Math.floor(Math.log(filesize) / Math.log(1024));
    return (filesize / Math.pow(1024, e)).toFixed(0) + text[e];
};

let getStartDate = function() {
	var date = new Date();
	var sel_month = -2;
	date.setMonth(date.getMonth() + sel_month); 
	
	var year    = date.getFullYear();
	var month   = leftPad(date.getMonth() + 1);
	return year+'-'+month+'-01';
};

let getEndDate = function() {
	var date = new Date();
	date.setMonth(date.getMonth() + 1); 
	date.setDate(0); 
	
	var year    = date.getFullYear();
	var month   = leftPad(date.getMonth() + 1);
	var day = leftPad(date.getDate());
	
	return year+'-'+month+'-'+day;
};

let getStartDay = function(){
	var date = new Date();
	date.setDate(date.getDate() - 2);
	
	var year    = date.getFullYear();
	var month   = leftPad(date.getMonth() + 1);
	var day = leftPad(date.getDate());
	
	return year+'-'+month+'-'+day;
};

let getEndDay = function(){
	var date = new Date();
	
	var year    = date.getFullYear();
	var month   = leftPad(date.getMonth() + 1);
	var day = leftPad(date.getDate());
	
	return year+'-'+month+'-'+day;
};