# Process + Architecture

Everything hosted in UCD Datacenter.

# UGA Admissions.

Process runs every term, but the main one is Fall.

Used to be everything under Banner, adding "Admissions" tables within Banner but within Admissions section?

Banner's been on campus for 35ish years. It kept on getting modivied to fit campus needs. Now it's pretty unweildy to maintain/modify.

So when Brian and Phil came up with a principle. `WHY_USER` stores Admissions specific data. When it needs to get shared with campus other than admissions then they try to chuck it into `BANNER`

If data doesn't need to be easily accessible, they just don't store it.

- PRINCIPLE: We will use banner to the best of our ability, but when we can't use what's there, we'll store it somewhere else.

Most core data for ia is stored in Banner.

P3 (Protection Level). 

P1 directory
P2 UCD Email
P3 is SSN
P4 HIPPA / Financial Aid

# Apply_UC

Central application for applying to UC. Hoested by UCOP (UC Office of the President). Half the pool applies in the last minute within the last week. F26 120k apps (109k first years, 17k transfer)

WERE Responsible using `secure FTP` from UCOP to a secure location, then from there we have access to that location, do a cron job that hands it off to banner team who actually chucks it into BANNER. 

Every night (whil application is open for submissions (they open Aug 1 but you can submit--) Oct 1 - Nov 30) applicant info gets uploaded into their database.

ApplyUC XML -> gets sent to each school (for UCD it gets into Banner). This is done by Mid - Dec. `CPID`+`Term` is identifier for each person. 

# How are decisions made -- IA
## HR Review
IA is a bunch of tools combined together. 

out of 109 40k will be admitted. Office of the president has an admissions criteria called "comprehensive review" (rebranded to "HR review" est 2014) which has background context. For example "high school environment" (UCOP trend data, how many seniors, average test scores, etc.), "neighborhood", "environmental factors" (college board, AP stuff related to the school) etc. 

All these factors are reviewed by a person--a reader. Sometimes two. It used to be 2 people auto look at each app. Now 1 person looks at it, and a 2nd one if the statistically calculated score doesn't align (PV score). Mandates are insulated from readers.

Goal of Holistic Review is to score a student based on a Rubric (Highest High, High, Medium, Low, Lowest).

External readers augment the exising readers (100) in 6 weeks. Done by Jan 30th. But remember these are reccomendations, not decisions.

## Selection
EMAT (analytics team) aligns applicats with Major + HR score + Target(number of students) + Yield Percentage (only a certain percentage will say yes). 

Everyone from this gets categorized into 3 buckets (ADMITS 45k, WAITLISTS 18k, DENYS). This must turn into around 9k people. 

Getting this yield proper is SO IMPORTANT. Don't want to overenroll or under-enroll. Pepperspray incident & Covid are examples of when this went wrong. Waitlist is what saves this. EMAT will usually admit 95% of their target and put the rest on waitlist. 

# Admissions !!
Notified in myAdmissions tool.

## First Years 
Mid March is notification day

## Transfers
Mid Apirl is notification day

## SIR Deadline (Satement of Intent to Register)
May 18th. Several hundred walk away in the summer, but this is when most WAITLISTS get re-evaluated. 

# Finalization
Time to check records. Check every student and make sure all the stuff lines up. Add credit for CC. Everyone who intened to register, but don't add their documents get their offer rescinded. 

DATASOURCES:
1. Parchment -> Davis for transcripts

# ASIDES
## Changes
Comments are the keeper of knowlege. Dated with name of person who requested a new feature.

Every cycle there are changes to that XML. 


# Differences for Transfers
## Technical Evaluation
Not HR, it's much more data heavy about coursework / exams. If they have majors where their courses don't transfer / they don't meet the unit transfer. Compared to undegrad Transfer Evaluaters are allowed able to admit right then compared to readers. There are "targets" for each major/college-dean. Thats set 

Tranferability, Repeating courses (points down). They show up with a lot of crap. Phils tools remove a lot of crap. 

For slective majors it's a credit thing. For non selective 

GPA & Units. You have 2 english 1 math, 2 non Prereq + Major class reqs. 

17k apps -> 2-3k

Transfer SIR is June 1, finalization process is similar but with more documents. 

2 freshman for every 1 transfer. Told to achieve that by California state.

- https://www.ellucian.com/
- PeopleSOFT
- UCLA Home grown

UCReview is shared work so everyone was willing to use it. 