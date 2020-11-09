# What is jupyter-mathematica?
An image built off of [jupyter/base-notebook](https://hub.docker.com/r/jupyter/base-notebook/) that includes the free [Wolfram Engine for developers](https://www.wolfram.com/engine/).

# How to get started
`docker build -t jupyter-mathematica .`

`docker run -p 8888:8888 jupyter-mathematica`

Then inside the container, run `wolframscript` and login with your Wolfram username and password or get a free license [here](https://wolfram.com/developer-license). You can easily do this from within a shell in Jupyter. After you are logged in, run

``` sh
$PasswordFile // FilePrint
```
in the wolframscript session to get your license key. Create an empty directory somewhere on your host system named `license`. Copy and paste the output from the wolframscript command into a file named `mathpass` within that directory. We will mount this directory into the container when starting it from now on. Example:

``` sh
docker run -p 8888:8888 \
-v /home/$USER/jm-files/license:/usr/local/Wolfram/WolframEngine/12.1/Configuration/Licensing \
jupyter-mathematica
```

Now, we need to tell Jupyter about mathematica. Run the following commands in the container.

```shell
cd /home/jovyan/wolfram/WolframLanguageForJupyter
./configure-jupyter.wls add
```

Now, you should be able to start a Wolfram Language notebook. Keep in mind that any notebooks you create will be stored in temporary docker volumes. Consider bind mounting some local directory like this:

``` sh
docker run -p 8888:8888 -v /home/$USER/jm-files/work:/home/jovyan/work jupyter-mathematica
```

Full example mounting license file and work directory:

``` sh
docker run -p 8888:8888 -v /home/$USER/jm-files/work:/home/jovyan/work \
-v /home/$USER/jm-files/license:/usr/local/Wolfram/WolframEngine/12.1/Configuration/Licensing \
jupyter-mathematica
```

If the WolframLanguage Kernel doesn't appear, you may have to re-run the `configure-jupyter.wls add`. I have experience this behavior periodically. After running this command, wait ~20s and the kernel should appear.
