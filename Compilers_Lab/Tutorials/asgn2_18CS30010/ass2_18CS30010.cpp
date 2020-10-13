/*
Name : Avijit Mandal
Roll : 18CS30010
Assignment : 2
Date : 17/09/2020
*/
#define MAX_BUFF 		200
#define SYS_READ 		0
#define STDIN_FILENO	0

#include "toylib.h"
#include <stdio.h>
int min(int a,int b){
	return a<b?a:b;
}

int printStringUpper(const char *s){

	int character_count = 0,i;
	char current_character ;


	for(i=0; s[i]!='\0';i++)
		character_count++;

	char print_str[ character_count + 1 ];
	print_str[ character_count] = '\0';

	for(i = 0;i<character_count;i++){
		current_character = s[i];
		if(current_character >= 'a' && current_character <='z')
			print_str[i] = current_character + 'A' - 'a';
		else print_str[i] = current_character;
	}

	__asm__ __volatile__ (
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t" 
 
        "syscall \n\t"
        :
        :"S"(print_str), "d"(character_count)
    );

	return character_count;

}

int readHexInteger(int *n){
	char buff[MAX_BUFF];
	int buff_len,ret_num = 0;

	int is_negative = 0 ;


    asm volatile("syscall" 
      : "=a" (buff_len) 
      : "0" (SYS_READ), "D" (STDIN_FILENO), "S" (buff), "d" (sizeof(buff))
      : "rcx", "r11", "memory", "cc");

    buff[buff_len - 1] = 0x0;
    buff_len-=1;
    int st_pos = 0 ,  end_pos = buff_len-1;

    //Removing LEADING spaces

    while(st_pos <end_pos && buff[st_pos] == ' ')
    	st_pos++;

    if (buff[st_pos]=='-'){
    	is_negative = 1;
    	st_pos++;
    }

    //Remove TRAILING spaces

    while(end_pos>st_pos && buff[end_pos] == ' ')
    	end_pos--;

    int mul = 1;
 	
 	if( end_pos - st_pos > 8 ) 
 		return BAD; 

    while(end_pos>=st_pos){
    	char ch = buff[end_pos];
    	if(ch>='0' && ch<='9'){
    		ret_num = ret_num + (ch-'0')*mul;

    	}
    	else if( ch>='a' && ch<='f' ){
    		ret_num = ret_num + (ch - 'a' + 10)*mul;
    	}
    	else return BAD;
    	mul = mul * 16;
    	end_pos--;
    }

    if(is_negative)
    	ret_num = - ret_num ;
    *n = ret_num ;
    return GOOD;
}

int printHexInteger(int n){
	int n1 = n;
	char buff[MAX_BUFF];
	char hexBuff[MAX_BUFF];

	int char_count = 0, is_negative = 0, chx_count = 0;
	if(n<0){
		is_negative = 1;
		n=-n;
	}
	while(n){
		buff[char_count++] = n%2 + '0';
		n/=2;
	}

	if(is_negative){
		hexBuff[chx_count++]='-';
	}
	int cnt = 0 ,mul = 1 , temp = 0;
	for(int i=0;i<char_count;i++){

		int num = (buff[i]-'0');
		num = num*mul;
		temp = temp + num;
		mul*=2;
		cnt++;
		if(cnt==4 || i==char_count - 1){
			if(temp<10)
				hexBuff[chx_count++]=temp+'0';
			else
				hexBuff[chx_count++]=temp-10+'a';

			cnt = temp = 0;
			mul = 1;
		}

	}
	int st_ind = is_negative , end_ind = chx_count-1;

	while(st_ind <end_ind){

		char ch = hexBuff[st_ind];
		hexBuff[st_ind] = hexBuff[end_ind];
		hexBuff[end_ind] = ch ;

		st_ind ++ ;
		end_ind --;
	}

	if(n1==0)
		hexBuff[chx_count++]='0';
	hexBuff[chx_count++]='\0';

	int x =  printStringUpper(hexBuff);
	return x;
}

int readFloat(float *numFrac){
	int int_part = 0;
	float frac_part = 0;
	int is_negative = 0, buff_len;
	char buff[MAX_BUFF];

	int c1 = 0, c2 = 0;
    asm volatile("syscall" 
      : "=a" (buff_len) 
      : "0" (SYS_READ), "D" (STDIN_FILENO), "S" (buff), "d" (sizeof(buff))
      : "rcx", "r11", "memory", "cc");

    buff[buff_len - 1] = 0x0;
    buff_len-=1;
    int st_pos = 0 ,  end_pos = buff_len-1;

    //Removing LEADING spaces

    while(st_pos <end_pos && buff[st_pos] == ' ')
    	st_pos++;

    //Remove TRAILING spaces

    while(end_pos>st_pos && buff[end_pos] == ' ')
    	end_pos--;

    if (buff[st_pos]=='-'){
    	is_negative = 1;
    	st_pos++;
    }

    if(end_pos - st_pos + 1 == 1)
    	if(buff[st_pos]=='.')
    		return BAD;

    int div = 10;
    while(st_pos<=end_pos){
    	if(buff[st_pos]=='.')
    		break;

   		if(buff[st_pos]>='0' && buff[st_pos]<='9'){
   			int_part = int_part*10+(buff[st_pos]-'0');
   		}
   		else return BAD;	
   		st_pos++;
   		c1++;
   		if(c1>6)
   			return BAD;
    }

    st_pos++;
    if(st_pos-1==end_pos)
    	return BAD;
   	while(st_pos<=end_pos){
    	if(buff[st_pos]>='0' && buff[st_pos]<='9'){
	    	frac_part = frac_part+(buff[st_pos]-'0')/(div*1.0);
	    	div = div*10;
   		}
   		else return BAD;

   		st_pos++;

   		c2++;
   		if(c2>11)
   			return BAD;

   	}
   	*numFrac = (is_negative?-1:1)*(int_part+frac_part);
   	return GOOD;

}

int printFloat(float f){

	char buff[20];
	int char_count = 0;
	int c2 = 0;

	int st_pos = 0;
	if(f<0){
		buff[char_count++]='-';
		st_pos++;
		f=-f;
	}

	int num = f ;

	float dub = f - num;
	if(num==0){
		buff[char_count++]='0';
		buff[char_count++]='.';
	}
	else{
		while(num){
			buff[char_count++]=num%10+'0';
			num/=10;
		}

		int end_pos = char_count - 1; 
		while(st_pos<end_pos){
			char ch = buff[st_pos];
			buff[st_pos] = buff[end_pos] ;
			buff[end_pos] = ch;

			st_pos++;
			end_pos--;
		}

		buff[char_count++]='.';
	}
	c2 = 0;
	int _f = (dub)*(1000000.000);
	char t1[7];

	while(c2<=6){
		t1[c2++] = _f%10 + '0';
		_f = _f/10;
	}
	for(int i=5;i>=0;i--){
		buff[char_count++]=t1[i];
	}
	buff[char_count++]='\0';
	printStringUpper(buff);
	return char_count;


}