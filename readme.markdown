DPovray
========

DPovray stands for distributed Povray. It is a tool that you can use to use many computers – a cluster – to render any nu ber of povray scenes in parallel.       
         

Installing
============

You need to install Git, Ruby and Redis.

Once you have installed Git and Ruby you can do:
                                        
    $ gem install bundler
    $ git clone https://Nerian@github.com/Nerian/DPovray.git
    $ bundle install

Configuration
=============

You need to configure the host and port where the Redis database is going to run. By default uses localhost:6379 which are redis's defaults.

Configuration can be set at the file `config/resque`
                        
	# Default is development
    development: localhost:6379
    test: localhost:6379     

The database could be anywhere. It could over the internet if you wish. But given that DPovray store images it can consume a lot of bandwidth, so it is advisable that the DB runs on the local network – for speed.

The password for accessing the Redis DB is read from ENV['AUTH'], an environment variable. You can set the variable on your .bash_profile, for example. It defaults to no password at all.


Workers
===============

The rendering process is done by Workers. To run a worker `cd` to where you have installed dpovray and do:

    $ QUEUE=* rake resque:work

The worker will connect to the Redis DB and it will start to pull jobs immediately. 


The graphical interface
========================

You can a web interface to monitor the cluster: what is each worker doing, jobs, projects, etc. You also use this web interface to add projects – povray scenes to render.
    
To run the web server `cd`to where you installed DPovray and run:
	
    $ rackup -p 3000

The `-p` is used to specify the port. It is Rack application. You can configure the Rack application in the file config.ru

The web interface looks like this:

<img src='http://dl.dropbox.com/u/834494/web.png'></img>

You can add new project in the New_Project tab and download the images in Project_Statuses 


Communication
==============

Questions, features, problems: https://github.com/Nerian/DPovray/issues 


Licence
=========


Licence
The MIT License

Copyright (c) 2011 Gonzalo Rodríguez-Baltanás Díaz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

