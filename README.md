# nps_service

### Background

At Homeday, we're very interested feedback from our customers: whether people like our apps and features and how would they rate them overall. The current feedback process is broken:

- we use a myriad of external apps to track feedback
- we don't define points where we track feedback
- we have no unified way of tracking feedback about features, or the important parts of the user journey
- the process of getting the feedback data is fragmented and complicated

Our idea is to build a service that would allow us to track NPS related to all touchpoints of the user journey.

### Vocabulary

- NPS: [Net Promoter Score](https://en.wikipedia.org/wiki/Net_Promoter) - we use a scale of 0..10.
- Touchpoint: a defined point of user journey where we ask for feedback
- Subject: the thing that is rated (e.g. a property for sale, a specific deal, or a real estate agent)
- Respondent: the user that submits the score
- Property: property for sale: house, apartment, etc.
- Realtor: the real estate agent that is tasked with selling a property on behalf of the owner
- Deal: A deal between the owner of the property and a realtor to sell the property.

### Usecases

#### A. Initial tracking

- The respondent signs up for Homeday as a seller
- The respondent picks a real estate agent to sell his/her property
- After a while, the respondent receives an email with "How would you rate your experience with the real estate agent John Doe"
- The respondent sees a scale of 0 to 10 and can click any number
- Let's say the respondent clicks "9".
- The NPS service records the following:
  - score (9)
  - touchpoint (string, let's use realtor_feedback)
  - respondent_class (string: let's use seller)
  - respondent_id (the unique ID representing this respondent)
  - object_class (string: realtor)
  - object_id (the unique ID representing the realtor)

#### B. Handling duplicate submissions

- The respondent has completed all the steps from A
- The respondent opens the email again but this time clicks on "2"
- The service receives the same params as A except the score which is now 2
- The service overwrites the previous data, storing the new score "2" for these incoming params.

#### C. Getting data

- A Homeday BI team member sends the following params to the service:
  - touchpoint (required)
  - respondent_class (optional)
  - object_class (optional)

### Your task

Your task is to build a service that stores the NPS score along with the params specified in the usecase A and also supports usecase B, i.e. does not allow the same user to store multiple scores per touchpoint/respondent/object.

The service should have:
- an endpoint that accepts the params and stores them (usecase A+B)
- *bonus points*: an endpoint that returns stored data (usecase C)

We also expect the service to handle errors and respond with meaningful status and error messages. Some error cases are:
- Not all parameters have been provided
- Invalid score has been provided
- Data integrity issues

### Requirements

The service should be written in Ruby.
The rest - framework, libraries/gems/external services - is entirely up to you.

One important requirement is to make sure the service you build can't be tampered with. Think about possible misuse of the service and the effects in can have on the business. 

### What we expect as a result

- a Github repo with your code
- tests, obviously
- a rationale behind the choices you've made

### Some hints

- Response time is important
- Data integrity is VERY important. No tampering with the NPS should be possible.
