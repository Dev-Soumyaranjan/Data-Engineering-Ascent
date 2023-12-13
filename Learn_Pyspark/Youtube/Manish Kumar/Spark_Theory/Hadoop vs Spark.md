##### Misconceptions
```diff
- Hadoop is a Database
- Spark is 100 times faster than Hadoop
- Spark processes data in RAM but Hadoop doesn't
```

|Parameter|Hadoop|Spark|      
|------|------|------|
|Performace|Hadoop is slower than Spark because it writes the data back to disk and read again from disk to memory<br> <img src="https://drive.google.com/uc?id=1mpWxJEV1gceE4cfbE8JWQAXX0H9xO7qU" alt="drawing" style="width:350px;"/>|Spark is faster than hadoop because spark do all the computation in Memory<br><img src="https://drive.google.com/uc?id=1SzzfCFdGVuFCFDQU96odkgjOZvqaAfBk" alt="drawing" style="width:350px;"/>       |       
|Batch/Streaming|Build for batch data processing|Build for batch as well as streaming data processing|    
|Ease of use|Diffibult to write code in Hadoop.Hive was built to make it easier|Easty to write and debug code.We have interactive shell to develop and test. Spark provides high level and low level API|     
|Security|Uses Kerberos Authentication and ACL authentication<br> YARN --> Kerberos|Doesn't have solid security feature<br>HDFS --> ACL <br> YARN --> Kerberos|     
|Fault-Tolerance|It is having block of data replication factor to handle the failure<br><img src="https://drive.google.com/uc?id=1uZc6U3VcOJw833DKMBIA3W23MG50M4R_" alt="drawing" style="width:350px;"/>|Uses DAG to provide the fault tolerance<br><img src="https://drive.google.com/uc?id=1N6ghVToRrFLsjX5vDW4Up5vw8LAtFQNK" alt="drawing" style="width:350px;"/>        |  
