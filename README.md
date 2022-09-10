# sro-thp
Simplero Take Home Project

Welcome!

We’ve designed this project for you to learn a TON in a short amount of time. We want it to be a valuable experience for you in your journey, by exposing you to technologies and thinking that you may not have been aware of.

It’s a living project from our side, meaning we’re always adding to it to make it more educational.

We welcome your feedback. Just hit me up at calvin@simplero.com.

With that, let’s get to it.


### **You'll learn...**

You're going to learn a bunch of exciting new technologies 



* [Rails 7](https://rubyonrails.org)
* [Stimulus](https://stimulus.hotwired.dev)
* [TailwindCSS](https://tailwindcss.com)
* [ViewComponent](https://viewcomponent.org)
* [FontAwesome](https://fontawesome.com)

In the end, you’ll be deploying the app you’ve built to Heroku or any other hosting solution of your choice


### **The big idea**



1. We would like you to build a simple lightweight community platform that allows people to create & join “Groups”.
2. There’s a group directory that lists all groups.
3. Users can join multiple groups and create posts on groups they’re a member of.
4. Other members can join the discussion by commenting on a post, as well as reply to comments.
    1. Comment replies should be shown indented below the comment they’re replying to
    2. Only one level of replies
5. Members can edit/delete their own posts & comments.
6. The creator of the group can 
    3. Edit/delete any post/comments on the group.
    4. Remove members that currently have access to the group
7. Login - How it works is totally up to you. Just a super simple login mechanism with an email and a password field. You can use something like Devise to manage sessions or implement something on your own. Whatever is quickest for you.
    5. (Bonus) If you want to implement registration
    6. Otherwise, you can just generate 10 random users 
    7. Whatever you do, create two users, [calvin@simplero.com](mailto:calvin@simplero.com) and [owais@simplero.com](mailto:owais@simplero.com), both with password ‘simplero’ so we can test the app
8. Finally, you are going to be deploying this app to heroku or any hosting solution of your choice for us to review. As well as submit the source code repository `for review.


### **Screens**

**Use this URL to view the screens if the below image is not clear - [https://excalidraw.com/#json=6Ws9uYfRwsM38a6r12Mgn,F-b-6HcA3yZc907APs5fnQ](https://excalidraw.com/#json=6Ws9uYfRwsM38a6r12Mgn,F-b-6HcA3yZc907APs5fnQ)**

Treat this as a general direction and don’t deviate too much from this. If there are things missing here, feel free to come up with a design on your own.

Do create a design that looks like this illustration.

**Note that <span style="text-decoration:underline;">all</span> of the UI should be done using standard Rails templates and views, with Stimulus for interaction, EXCEPT where specifically directed to use React.**



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")



### **Getting started**



1. Start by setting up a fresh Rails 7 project, with TailwindCSS, Stimulus, ViewComponent,  a database of your choice (remember you need to deploy this app to Heroku or something similar - we recommend PostgreSQL to ease that process if you’re going to use Heroku)
2. You should be writing all styles with TailwindCSS. For icons, please use icons from [FontAwesome](https://fontawesome.com/) (add icons wherever you think it’s appropriate)
3. Use ViewComponents to componentize various elements. For ex: rendering a comment - create a view component, that takes in a Comment object and renders it.
4. Use StimulusJS to write client-side JavaScript behaviors to improve UX wherever possible. For ex: when editing a post, you can make it so that the editor form and the post content are both rendered if you have access to edit the post. But the editor form is hidden by default. When someone clicks on the edit buttons, it hides the post preview and shows the editor button. This can be handled by StimulusJS.
5. All text content (like editing a post/comment/reply) will be a simple &lt;textarea> field.
6. If you’ve got any questions, feel free to ask them in Slack.


### **Notes**



1. **<span style="text-decoration:underline;">Please follow all the requirements we’ve mentioned in “The big idea” and technologies you should use that we’ve noted in “Getting started” above. </span>**
2. Make sure you work in a git repository. Ideally, commit changes as you would when working in a real app (isolating related changes in a single commit with descriptive messages) - This would allow us to review your work better.
3. If you’re done with everything and still have got time left, feel free to impress us with your own features.
