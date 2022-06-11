//#include <iochaream>
#include <stdio.h> // define the header file  
int main()   // define the main function  
{  
    char msg[] = "Hello";
    char key[] = "efbcdghijklmnopqrstuvwxyza";
    char encrypt[] = '';
    printf(encrypt(msg, key, encrypt));
} 



void encrypt(char msg[], char key[], char encrypted_msg[]){
    char alph[] = "abcdefghijklmnopqrstuvwxyz";
    for (int i=0; i < msg.length(); ++i){
        for (int j=0; j < 26; ++j){
            if (msg[i] == alph[j]){
                encrypted_msg[i] = key[j]; 
            }
        }
    }
    return encrypted_msg;
};

void decrypt(char msg[], char key[], char encrypted_msg[]){
    char alph[] = "abcdefghijklmnopqrstuvwxyz";
    for (int i=0; i < msg.length(); ++i){
        for (int j=0; j < 26; ++j){
            if (msg[i] == key[j]){
                encrypted_msg[i] = alph[j]; 
            }
        }
    }
    return encrypted_msg;
};