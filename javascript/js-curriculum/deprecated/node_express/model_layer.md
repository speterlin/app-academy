# This Document is under construction

# TODO

* Structure
  * MongoDB/NoSQL Intro
  * Open a connection
  * Define schemas and methods
  * Create records
  * Retrieve records
  * Update records
  * Query for records
  * Delete records
  * Validate records
  * Organize code


![](http://www.omgwiki.org/model-interchange/lib/exe/fetch.php?cache=cache&w=350&h=317&media=under-construction.gif)

# MongoDB

MongoDB is the database we'll be using with our Node.js projects. It's a
document-based database (sometimes also referred to as a NoSQL
database or _document store_).

MongoDB is different from relational databases like PostgreSQL and
SQLite. Instead of storing
rows in tables (_relations_), it stores a load of BSON documents
(_B_inary J_SON_).

So, in SQL you might have some table `cats`, with two records:

```
+----+------+----------+
| id | name | owner_id |
+----+------+----------+
| 2  | Ace  |    07    |
+----+------+----------+
| 1  | Onyx |    19    |
+----+------+----------+
```

In Mongo we'd have two JSON "documents", one for Ace:

```js
{
name:  "Ace",
owner: { Name: "Donald", Age: 43 }
}
```

And one for Onyx:
```js
{
name: "Onyx",
color: "black",
owner: { Name: "Rita", Age: 88 }
}
```

As you can see, the documents are just like JSON. They're simple,
flexible (_e.g._ only one of the cats has a `color`), and straightforward.

Note also that while in SQL you keep foreign keys, in a document store
like Mongo you usually put the _entire associated object_ in the document.
For simple associations like `belongs_to`, `has_many`, and `has_one`,
this works just fine, but as you may have already realized, modeling
more complex relations becomes a bit more difficult. We'll cover
associations later on.

### Install MongoDB

Let's install MongoDB on your machine. You can check out
[the docs][mongo-install] for detailed instructions on installing Mongo on Linux,
Windows, and OSX. But your favorite package manager like `Homebrew` or
`MacPorts` should be able to do it for you:

[mongo-install]: http://docs.mongodb.org/manual/installation/
```bash
# in BASH
# with MacPorts
$ port install mongodb
```

### Mongod and Mongo

Like Postgres, the Mongo database and the shell are different
processes.

`mongod` is the "Mongo Daemon". Like _Postgres.app_ (the little
elephant), mongod is the host process for the database (the database
"server"). You connect to the databases with `mongo`, an interactive
command line shell with which you can make queries and insert data
(the database "client").

So let's start up a `mongod` process:

```
# BASH
mongod
```

You'll need to make sure this is running in a terminal tab or in the
background whenever you want to setup a database connection with a
client.

Okay, so our server process is running, so we can open a new terminal
window, and open an interactive shell with `mongo`:

```
# BASH
$ mongo
MongoDB shell version: 2.4.6 connecting to: test
>
```

Let's play around a bit in a new database called `mydb`.

```
> use mydb
```

**NB: You can always ask for `help`.**

Okay, so we're playing
with some new database, `mydb`. Let's create a document:

```
> ace = { name: "Ace", owner: { name: "Donald", age: 43 } }
{ "name" : "Ace", "owner" : { "name" : "Donald", "age" : 43 } }
```

Ace won't be in our database until we insert him, so let's
go ahead and insert him into a `cats` collection (like a table):

```
> db.cats.insert(ace)
> show collections # Verify that the collection was created.
cats
```

Now lets ask for all the cats:

```
> db.cats.find()
{ "_id" : ObjectId("526f034be7c343f959055e9f"), "name" : "Ace", "owner" : { "name" : "Donald", "age" : 43 } }
```

In Mongo, the primary key is set as `_id` which defaults to an
`ObjectId` which is a long unique string (well, it's not guaranteed to
be unique but it's highly unlikely to ever produce duplicates).

### Mongo CRUD

MongoDB has its own querying language (it doesn't use SQL). Read this
short [introduction from the MongoDB docs][mongo-intro]. We won't go too
in-depth here; reference what you need when you need it. Mostly we'll be
using Mongoose, an ODM layer that sits on top of MongoDB.

```
// Retrieve all
db.cats.find()

// Some queries
// Find cats with name 'Abby'
db.cats.find({name: 'Abby'})
// Find cats with age > 5
db.cats.find({age: { $gt: 5 }})
```

[mongo-intro]: http://docs.mongodb.org/manual/core/crud-introduction/

# Object-Document Mapping (ODM)

MongoDB can serve as our database, but it'd be nice to have an ORM like
ActiveRecord in Rails. Since we'll be using Node, we want a JavaScript
ORM. Express.js doesn't ship with one, so we'll use another; two of the
most popular solutions are Mongoose and JugglingDB.

[Mongoose][mongoose] is an ORM for MongoDB. By the way, sticklers would
correct me and say that Mongoose is an _ODM_ (Object Doument Mapper) not
an _ORM_ (Object Relational Mapping), this is because MongoDB stores all
data in _documents_ not _relations_.

[JugglingDB][juggling-db] is a flexible ORM with adapters for many of
the popular databases, including PostgreSQL.

We'll be using Mongoose which is an ODM for MongoDB.

[mongoose]: http://mongoosejs.com/
[juggling-db]: http://jugglingdb.co/

## Mongoose

### Opening a Database Connection

So assuming you've gotten MongoDB to work, start up
the `mongod` process, and then create a new project
to play with _Mongoose_.

As before we'll create two files, `package.json` and `app.js`.
In `package.json` let's set up the proper dependencies:

```js
// in package.json
{
    "name": "mongooses-garden",
    "description": "Mongoose Test App",
    "version": "0.0.1",
    "dependencies": {
        "mongoose": "3.6.x"
    }
}
```

And we'll install our dependencies (in this case just `mongoose`):

```
$ npm install
```

So the first thing we'll need to do in our projects is include the
Mongoose library, and open a connection with the database:

```js
// app.js
var mongoose = require('mongoose');

var db = mongoose.connection;
// Basic error checking
db.on('error', console.error.bind(console, 'connection error:'));

mongoose.connect('mongodb://localhost/test');
```

Connected!

### Our First Transaction

Let's write a transaction.

#### Schema

For each model, you'll first define a schema, then define model methods,
then register the model with Mongoose.

First we'll define a [schema][mongoose-schema]:

```js
var CatSchema = mongoose.Schema({
    name: String,
    age: Number
});
```

This schema will define the shape of the cat documents that will go into
the database. Each key in the schema defines a property in our documents
which will be cast to its associated [SchemaType][schema-type] (_e.g._
`String`, `Boolean`, `Date`, `Number`).

Models are fancy constructors compiled from Schema definitions. Thus
before we define any models, we must first create their
schema.

This is also where we can define instance methods:

```js
CatSchema.methods.meow = function () {
    console.log("meow! (from " + this.name + ")");
};
```

In model methods, you have access to all the properties of the model
using `this`.

Finally, register the schema with Mongoose to create the model:

```
mongoose.model('Cat', CatSchema);
```

Note that you have to be finished with the schema _before_ you pass it
to the model constructor. So make sure you've defined all of your
instance methods ahead of time.

#### Models

We can retrieve the model by name:

```js
var Cat = mongoose.model('Cat');
```

And finally we'll create and save some cat models:

```js
  var onyx = new Cat({ name: 'Onyx', age: 5 });
  var ace = new Cat({ name: 'Ace', age: 5 });

  var catSaveCallback = function (error, cat) {
      if (error) {
        console.log("error.");
      } else {
        cat.meow();
        console.log("saved: " + cat.name);
      }
  };

  onyx.save(catSaveCallback);
  ace.save(catSaveCallback);
```

Database queries - reads and writes - are asynchronous, so you'll pass a
callback to them. All the callbacks take as a first argument an error.
On save, the model is the second argument to the callback.

We can just as simply remove a cat from the store (but we'd never want
to do that).

```js
Cat.remove({ name: 'Ace' }, function (error) {
  if (error) return handleError(error);
    // you.cry();
});

```

### Querying

Now let's retrieve them:

```js
    Cat.find(function (err, cats) {
      if (err) { console.log(error) }
      console.log("found cats: " + cats)
    });
```

[mongoose-schema]: http://mongoosejs.com/docs/guide.html
[schema-type]: http://mongoosejs.com/docs/schematypes.html

#### Validations

Validations are baked in to the schema just by specifying the schematype.
If you want to require a field you can simply specify that you require it:

```js
var s = new Schema({ born: { type: Date, required: true })
```

Likewise, if we didn't want any duplicate names in our database, we
might have said:

```js
var catSchema = new Schema({ name: {type: String, unique: true }});
```

For more complex validations, [look here][custom-validation].

[custom-validation]: http://mongoosejs.com/docs/api.html#schematype_SchemaType-validate

#### Back to Queries

When a callback function is passed to a query, the operation will be
executed immediately with the results passed to the callback.  However,
if it is not passed, an instance of Query is returned, which provides a
special QueryBuilder interface for you. This way, you can chain Queries.

```js
Cat
.find({ color: /black/ })
.where('name').equals('Onyx')
.where('age').gt(17).lt(66)
.limit(10)
.select('name occupation')
.exec(callback);
```

As you can probably glean from this example (which wont work with our
schema) you can force a chained query to execute later with
`Query#exec(callback)`. Note that the callback takes two args (error,
and results).

More on queries [here][queries-docs]

[queries-docs]: http://mongoosejs.com/docs/queries.html

### Associations

OK, so like we said earlier, Associations can be a bit complicated in
a document store like Mongo.  And most often, instead of making an
association, we'll simply nest documents. But sometimes we'll really
need references to other documents (like in a one to many
relationship). This is where the [population][population-docs]
function comes in handy.

In essence, `population` is a function which, when called on a model
with a field that references another document, will populate that
field with the referenced document.

So say we have `Person`s and `Cat`s, and the `Cat`s have a `guardian`,
and one person can have many `Cat`s:

```js
    var personSchema = mongoose.Schema({
        _id     : Number,
        name    : { type: String, unique: true },
        age     : Number,
    });

    var catSchema = mongoose.Schema({
        _guardian : { type: Number, ref: 'Person' },
        name      : { type: String, unique: true },
        color     : String,
    });

    var Cat = mongoose.model('Cat', catSchema);
    var Person = mongoose.model('Person', personSchema);
```

Our `Cat` model has its `_guardian` field set to a ref to the
associated `Person._id`. The `ref` option tells Mongoose which model to
use during population. It's very important that these `ref` fields
match the type of the field they're referencing.

We'll stick with `ObjectId` or `Number` type refs, but you can also
use `String`s and `Buffers`.

#### Using Populate

So let's create some associated documents.

```js
var ryan = new Person({
    _id: 0,
    name: 'Ryan',
    age: 24
});

ryan.save(function (err) {
    if (err) return handleErr(err);

    var onyx = new Cat({
        name: 'Onyx',
        _guardian: ryan._id,
        color: 'black'
    });

    var ace = new Cat({
        name: 'Ace',
        _guardian: ryan._id,
        color: 'tortise shell'
    });

    var catSaveCallback = function (err) {
        if (err) return handleErr(err)
    }

    ace.save();
    onyx.save();
});
```

So when we're fetching a cat model, we will call the populate method
to replace the ref field with the associated document from the `People` collection.

```js
Cat
.findOne({ name: 'Onyx' })
.populate('_guardian')
.exec(function (err, cat) {
  if (err) return handleError(err);
    console.log('My guardian is %s', cat._guardian.name);
})
```

But what if I wanted to show all of a `Person`'s `Cat`s?  Instead of
keeping track of refs in two directions (because that could easily get
out of sync) let's just define a model on `Person` that does a search
for their `Cats`.

Remember, we have to do this before we pass the `personSchema` into the model constructor!

```js
personSchema.methods.cats = function (cb) {
  return this.model('Cat').find({ _guardian: person._id }, cb);
}
```

So now we will have access to a `Person`s cats.

```js
ryan.cats(function (err, cats) {
    // do something with the cats
})
```

[population-docs]:http://mongoosejs.com/docs/populate.html

# Resources

The Mongoose documentation is quite good, take a look at their guide
and the examples contained within:

* [Mongoose Quickstart](http://mongoosejs.com/docs/index.html)
* [Mongoose Guide](http://mongoosejs.com/docs/guide.html)
* [MongoDB Manual](http://docs.mongodb.org/manual/)
