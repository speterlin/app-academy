# Express Starter App

Make sure you reference the readings as you work through this starter
application because much of what you need is demonstrated in them.

The [Express.js demo][express-demo] may also be very helpful.

[express-demo]: https://github.com/appacademy/express-demo

## Phase I: Hello, World!

Create a folder for your project, create a `package.json` file and a
`server.js` file, and setup your server.

Define a single action on the root path `"/"` that renders the text
"Hello, World!".

Test it out (throughout the project, test things out in the browser
frequently).

Let's also go ahead and add the express logger to our app so that we
have some information in our sever logs.

## Phase II: First Controller

You've got an HTTP server up and running! Let's put the next few actions
we write into a separate file.

Create an `app` and an `app/controllers` folder, create a file
`app/controllers/first_controller.js`. Define an action on
`"/hello"` in `first_controller.js` that renders "Hello from the
controller!". 

Refer to the [Code Organization](./code_organization.md) reading to
require `first_controller.js` and other future controllers in your
`server.js` (note the `exports.init` pattern). 

## Phase II: First View

Time to render a view. Create a `app/views` folder and a
`app/views/index.ejs` file. Create a controller action in
`first_controller.js` on `"/index"` that renders the `index.ejs`
template. Put whatever you'd like in the template; just make sure you
actually use some embedded javascript, even if it's just adding some
numbers up.

You'll have to tell your app to look in `app/views` for the view
templates.

## Phase III: Static Assets

Create a `app/assets/` folder and `javascripts/` and `stylesheets/`
folders in `assets/`. Create an `app.js` file and an `app.css` file and
put them in the proper folders.

Put a `console.log` statement in `app.js` and add some style definition
to `app.css` that will cause some visible change in `index.ejs`.

Configure your app to serve up static assets (check the readings) in the
`assets/javascripts` and `assets/stylesheets` folders.

Add the proper `link` and `script` tags to `index.ejs` and test to make
sure the assets are being served up properly.

Once you have it working, pull out the `link` and `script` tag and put
them in a template called `head.ejs` and `include` that template in
`index.ejs`.

## Phase IV: Cookie Counter

You've got your directory structure setup, a controller going, static
assets being served up properly - almost everything you need to build a
full application. Only a few things left to work through.

First up, cookies!

Create a `"/counter"` action that should keep a count of how many times
the user has visited that page. It should render the count in the
response and increment it in the response cookie.

You'll have to configure the app to parse the cookies for you. Check the
readings for how to do cookie manipulation.

## Phase V: POST Params

Let's create a trio of actions where you'll learn how to use POST body
params, redirect, and use the cookies again.

Make sure you have your `app` setup to use `express.bodyParser()` in
`config.js`. That's the piece of middleware that will actually parse the
POST data.

Create a template with a simple form (name, email) that will POST to
`"/params"`. Create an action `"/new"` that will render the form
template. Create an action `"/show"` that the POST action will
redirect to.

The POST action should take the params from the post request, store them
in the cookie, and redirect to the show action. The show action should
take whatever is in the cookie and render it to the response.

## Phase VI: Mongoose

Alright, you're ready to add some persistence to the mix.

### Setup Mongoose

Setup the database connection in `server.js`. Make sure to also include
a simple error logger `db.on('error', ...`.

Your models will go in `app/models` so use a similar pattern as with
your controllers to require them all in. Use `fs` to read the filenames
in the folder and require each in turn. Your models will not have to
export anything since they will simply register themselves with
mongoose.

### User model

Create a user model that takes a name and an email, both required.

## Phase VII: Users

Create a users controller and a folder for its views.

* `app/controllers/users.js`
* `app/views/users/`

Write the following actions:
* New (form for new user)
* Create (persist user to db, redirect to show)
* Show (display user)
* Index (display all the users)

At the top of your controller, you'll want to require your User model:

```
var mongoose = require('mongoose');
var User = mongoose.model('User');
```

Now you can use `User` in your controller actions (`new User`,
`User.findById`, `User.save`).

Test everything out.

## Phase VIII: Posts

Each user has many posts.

* Post model
* Take a look at Mongoose populations for how to nest models (you'll
  keep the posts in the user document)

## Phase IX: Auth

Sign In, Sign Out.

Protect posts.


## Phase X: Sharing Posts

A user can share posts with other users. Only the author and the shared
users can see a post.




