## Aug 20, 2026

### Standalone Tailwind CLI with Coldfusion

Today I'm exploring how to use the Tailwind CLI to create CSS files we'd like to use in this application. Bootstrap seems to be a simpiler way to do things as all you need to do is link their CDN in your script. But I feel like there is advantage to using this framework similar to how you would React. Also I want the full customization that comes with Tailwind.

To keep this process clean, I think it'd be a good idea to Dockerize the whole thing... since each cli is OS specific. Lets leverdge commandbox's docker instructions to do this.

Oh -- I also want to try out the ORM stuff. We'll do that after.

#### Setting Up Docker
I already had docker installed on my machine. If you don't have docker already, add it. I use my mac's package manager (homebrew) to do this.
```
brew install --cask docker
```

Then, once I've installed docker, I install Commandbox's official Docker image.
```
docker pull ortussolutions/commandbox
```

