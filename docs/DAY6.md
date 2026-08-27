## Sign in / Auth
Aug 27, 2026

After diving into the uctap repository code, I've decided to add some sort of authentication / login code similar to their setup to gain an understanding of what makes it secure, how it can be improved, etc.

Right now we're using REST to create an account since I'm lazy and I already have the logic written out. The importnat detail I learned is that for databases you don't store the password, instead you store the hashed version of the password to be decryped afterwards. Right now UCTap uses SHA512, which apparently is cheap to decrypt with guessing. I used Adobe's `GenerateBCryptHash()`

https://guides.adobe.com/coldfusion/en/docs/cfml-reference/generatebcrypthash.html