### Why Apache Spark?
In earlier days, to handle the data we were using **Database**

<img src="https://icons.iconarchive.com/icons/paomedia/small-n-flat/512/database-icon.png" alt="drawing" style="width:15px;"/>Database: Oracle,Teradata,MySQL,Exadata

> [!IMPORTANT]
> These systems were only supporting structure data

| Col1| Col2 | Col3 | Col4   |     
|-------|-------|-------|------|
|        |        |        |        |      
|        |        |        |        |    
|        |        |        |        |   
|        |        |        |        |    
|        |        |        |        |      

After invention of internet as it growed, different file format started generating

<img src="https://w7.pngwing.com/pngs/867/482/png-transparent-computer-icons-document-file-format-icon-design-basic-angle-text-rectangle.png" alt="drawing" style="width:20px;"/> File:Text,CSV,Image,Video,Audio etc.


```mermaid
stateDiagram-v2
    JSON,YML --> SemiStructured
```

  ### $Big\color{red}Data$
  
>[!NOTE]
> The definition of big data is data that contains greater variety, arriving in increasing volumes and with more velocity
  

```mermaid
stateDiagram
  direction RL
    state "3 V's of Big Data" as s1
    state "1 sec" as t1
    state "1 hour" as t2
    state "1 min" as t3
    state "Structured" as d1
    state "Semi-structured" as d2
    state "Unstructured" as d3
    state "5 GB" as g1
    state "10GB" as g2
    state "10TB" as g3
    s1 --> Velocity
    s1 --> Variety
    s1 --> Volume
   
    Volume --> v3
    Variety --> v2
    Velocity --> v1

    state v2{
      direction LR
      d1 --> d2
      d2 --> d3
    }
    state v3{
      direction LR
      g1 --> g2
      g2 --> g3
    }
    state v1{
      direction LR
      t1 --> t2
      t2 --> t3
    }

   d1 --> g1
   d2 --> g2
   d3 --> g3

   t1 --> d1
   t2 --> d2
   t3 --> d3
   v3 --> "BIGDATA"
  
```
**Issues**
1. Storage
2. Processing
   - RAM
   - CPU

```
Now there were two options to resolve these issues
```

```mermaid
stateDiagram-v2
    state "Options" as o
    state "Monolithic Approach(Vertical Scaling)" as m
    state "Distributed Approach(Horizontal Scaling)" as h
    o --> m
    o --> h    
```

|Monolithic|Distributed|     
|------|------|
|Vertical Scaling|Horizontal Scaling|   
| Expensive|Economical|   
| Low Availability|High Availability| 
| <img src="https://drive.google.com/uc?id=1fAnjmWEMsJx22kxmVEH7dkEmyCgjxk2r" alt="drawing" style="width:250px;"/>|<img src="https://drive.google.com/uc?id=1u4qn2JS80gi83nmy-qfMzL9GlBNaScWQ" alt="drawing" style="width:250px;"/> |  

