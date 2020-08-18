

inddat<-read.csv("/Users/quazi/Desktop/cric/irl.csv",header=T)
head(inddat)
str(inddat)
ttt<-nrow(inddat)/2   #total teams
i1<-inddat[1:ttt,]
i1
i2<-inddat[(ttt+1):(ttt+ttt),]
i2

NA2mean <- function(x) replace(x, is.na(x), mean(x, na.rm = TRUE))
i1<-replace(i1[,3:ncol(i1)], TRUE, lapply(i1[,3:ncol(i1)], NA2mean))
i2<-replace(i2[,3:ncol(i2)], TRUE, lapply(i2[,3:ncol(i2)], NA2mean))
i2
i1

i1<-cbind(inddat[1:ttt,2],i1)
i2<-cbind(inddat[1:ttt,2],i2)
i1
i1<-i1[-9,]
i2<-i2[-9,]
head(i1)
head(i2)
m<-(ttt-1)   #number of teams
n<-11    ##always 11

ie<-rbind(i1[1:m,],i2[1:m,])
ie

g<-as.data.frame(t(ie[,-1]))
g$myfactor <- factor(row.names(g))

g$myfactor<-str_remove_all(g$myfactor, "[V0123456789]")
k<-as.numeric(factor(g$myfactor))
g<-cbind(g,k)
g$myfactor <- factor(g$myfactor)


g2<-g[order(g$myfactor),]
g2[g2 == 0] <- 1
g2


autoirl<-function(){
        select<-strata(g2,stratanames=c("myfactor"),size=c(2,3,1,4,1), method = "srswor")
        #table(select$myfactor)
        hs<-getdata(g2,select)[,1:m]
        ave<-getdata(g2,select)[,(m+1):(m+m)]
        #hs
        #ave
        
        
        
        l2<-NULL
        for (i in 1:n){
                r1<-hs[i,]
                r2<-ave[i,]
                l1<-ifelse((r1<r2) | (r1==r2), max(r1,r2+15), r1)
                l2[i]<-list(l1)
        }
        #l2
        l3<-data.frame(matrix(unlist(l2), nrow=n, byrow=T))
        #l3
        
        l4<-NULL
        l5<-NULL
        for(i in 1:n){
                for (j in 1:m){
                        
                        a<-l3[i,j]
                        b<-ave[i,j]
                        score<-f(b,a)
                        l4[j]<-(score)
                }
                l5[i]<-list(l4)
        }
        
        score<-data.frame(matrix(unlist(l5), nrow=n, byrow=T))
        #score
        #ave
        #l6<-ifelse(is.na(score), ave, r1)
        #is.na(score)
        score<-ceiling(score)
        scores<-colSums(score)
        #scores
        list(scores=scores)
}


autoirl()


irlsims<-replicate(5,autoirl())
irlsims[[1]][5]
id<-data.frame(matrix(unlist(irlsims), nrow=length(irlsims), byrow=T))
id
colnames(id)<-c("v Afghanistan","v Australia", "v Bangladesh","v Bermuda", "v Canada",
                "v England",
                "v Hong Kong","v India","v Kenya","v Netherlands",
                "v New Zealand", "v Pakistan", "P.N.G." ,"v Scotland", "v South Africa", 
                "v Sri Lanka" ,"v U.A.E.","v West Indies","v Zimbabwe" )
ed$`v India`
ia$`v England`
bh$`v India`
ia$`v Bangladesh`
nd$`v India`
ia$`v New Zealand`
pn$`v India`
ia$`v Pakistan`
ia$`v South Africa`
sa$`v India`
ska$`v India`
ia$`v Sri Lanka`
ws$`v India`
ia$`v West Indies`
ia$`v Zimbabwe`
ze$`v India`
id$`v India`
ia$`v Ireland`
bh$`v Ireland`
id$`v Bangladesh`

