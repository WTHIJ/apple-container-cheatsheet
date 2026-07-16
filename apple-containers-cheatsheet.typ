// ─── Apple Containers CLI Cheatsheet ────────────────────────────────────────

#set page(paper: "a4", margin: 0.8cm, columns: 4, flipped: true)
#set columns(gutter: 0.1cm)
#set text(size: 8pt, font: "Liberation Sans")
#set par(spacing: 0.4em)

#let section(title) = block(
  fill: rgb("#2c3e50"),
  inset: (x: 4pt, y: 2pt),
  radius: 2pt,
  width: 100%,
  text(fill: white, weight: "bold", size: 7pt, title),
)

#let subsection(title) = block(
  fill: rgb("#ecf0f1"),
  inset: (x: 3pt, y: 1pt),
  radius: 1pt,
  width: 100%,
  text(weight: "bold", size: 6.5pt, title),
)

#let code(body) = block(
  fill: rgb("#f8f8f8"),
  stroke: 0.5pt + rgb("#cccccc"),
  inset: 2pt,
  radius: 2pt,
  width: 100%,
  text(font: "Liberation Mono", size: 5.7pt, body),
)

#let note(body) = block(
  fill: rgb("#fff3cd"),
  stroke: 0.5pt + rgb("#ffc107"),
  inset: 3pt,
  radius: 2pt,
  width: 100%,
  body,
)

// ─── Title ───────────────────────────────────────────────────────────────────

#text(size: 9pt, weight: "bold", "Apple Containers CLI Cheatsheet")
#linebreak()
#text(size: 5.5pt, style: "italic", "Practical command reference for `container` on macOS.")
#linebreak()
#text(
  size: 5.5pt,
  style: "italic",
  "Inspired by and adapted from the official Apple `container` repository documentation.",
)

// ─── System ──────────────────────────────────────────────────────────────────

#section("System")

#subsection("Service Management")
#code(
  ```bash
  # Starts Apple Containers services
  container system start

  # Stops Apple Containers services
  container system stop
  ```,
)

#subsection("Info & Help")
#code(
  ```bash
  # Shows CLI + API server version details
  container system version --format table

  # Lists top-level commands and options
  container --help
  ```,
)

#subsection("Service Logs")
#code(
  ```bash
  # Displays logs from the container services
  container system logs

  # Follows logs in real time
  container system logs --follow

  # Shows only the last N log lines/duration
  container system logs --last 1h
  ```,
)

#subsection("List Containers")

#code(
  ```bash
  # Lists all containers (running + stopped)
  container ls -a
  ```,
)

// ─── Build an Image ──────────────────────────────────────────────────────────

#section("Build an Image")

#code(
  ```bash
  # Creates a new directory for the Dockerfile and context
  mkdir web-test
  cd web-test
  ```,
)

#subsection("Dockerfile Example")
#code(
  ```dockerfile
  FROM docker.io/python:alpine
  WORKDIR /content
  RUN echo 'hello' > index.html
  CMD ["python3", "-m", "http.server", "80", "--bind", "0.0.0.0"]
  ```,
)

#subsection("Build")

#code(
  ```bash
  # Builds the image from the Dockerfile in the current directory
  container build --tag web-test --file Dockerfile .

  # Builds without using the cache
  container build --tag web-test --no-cache .

  # Passes a build-time variable
  container build --tag web-test --build-arg VERSION=1.2 .

  # Builds for a specific platform
  container build --tag web-test --platform linux/arm64 .

  # Builds a specific stage in a multi-stage Dockerfile
  container build --tag web-test --target builder .
  ```,
)

#note[
  #text(size: 5.8pt)[
    If `-f/--file` is omitted, the build looks for *Dockerfile* first, then falls back to *Containerfile*.
  ]
]

#subsection("Image Management")

#code(
  ```bash
  # Lists all images
  container image list

  # Lists images with verbose / quiet output
  container image list -v
  container image list -q

  # Pulls an image from a registry
  container image pull docker.io/library/nginx:latest

  # Pushes an image to a registry
  container image push myrepo/web-test:latest
  ```,
)

#colbreak()

// ─── Run & Inspect Containers ────────────────────────────────────────────────

#section("Run & Inspect Containers")

#subsection("Run a Container")

#code(
  ```bash
  # Runs a container and maps host port 8080 to container port 80
  container run --name my-web-server --detach --rm --publish 8080:80 web-test

  # Runs interactively with a shell attached
  container run -it ubuntu:latest /bin/bash

  # Sets an environment variable in the container
  container run -e NODE_ENV=production web-test

  # Limits CPU and memory usage
  container run --cpus 2 --memory 1G web-test

  # Bind mounts a host directory into the container
  container run -v ./data:/content web-test
  ```,
)

#note[
  #text(size: 5.8pt)[
    *`--detach`* — runs the container in the background (no terminal attached). #linebreak()
    *`--rm`* — automatically removes the container when it stops. #linebreak()
    *`--publish`* — maps a host port to a container port (`host:container`). #linebreak()
    *`-v/--volume`* — mounts a host path or named volume into the container.
  ]
]

#subsection("Create Without Starting")

#code(
  ```bash
  # Creates a container without starting it (like docker create)
  container create --name my-web-server web-test
  ```,
)

#subsection("Execute a Command Inside a Running Container")

#code(
  ```bash
  # Executes a one-off command inside the running container
  container exec my-web-server ls /content

  # Opens an interactive shell session inside the container
  container exec --interactive --tty my-web-server sh

  # Runs a command detached from the terminal
  container exec -d my-web-server long-task.sh

  # Runs a command with a custom working directory and env variable
  container exec -w /content -e DEBUG=1 my-web-server env
  ```,
)

#note[
  #text(size: 5.8pt)[
    Run `exit` to leave the interactive shell session.
  ]
]

#subsection("Copy Files To/From a Container")

#code(
  ```bash
  # Copies a file from the host into the container
  container cp ./config.json my-web-server:/etc/app/

  # Copies a file from the container to the host
  container cp my-web-server:/var/log/app.log ./logs/
  ```,
)

#subsection("Resource Stats")

#code(
  ```bash
  # Displays live resource usage statistics for the running container
  container stats my-web-server

  # Displays a single snapshot of resource usage (no continuous stream)
  container stats --no-stream my-web-server
  ```,
)

#subsection("Inspect Metadata")

#code(
  ```bash
  # Displays detailed metadata about the container
  container inspect my-web-server
  ```,
)

#subsection("View Logs")

#code(
  ```bash
  # Displays the logs from the container's stdout and stderr
  container logs my-web-server
  ```,
)

// ─── Lifecycle Operations ────────────────────────────────────────────────────

#section("Lifecycle Operations")

#subsection("Stop a Running Container")

#code(
  ```bash
  # Stops a running container by name or ID
  container stop my-web-server
  ```,
)

#subsection("Stop / Start Cycle")
#code(
  ```bash
  # Runs a detached container named test-stopstart
  container run --name test-stopstart --detach web-test

  # Stops the container
  container stop test-stopstart

  # Starts it again
  container start test-stopstart

  # Deletes the container
  container delete test-stopstart
  ```,
)

#colbreak()

// ─── Volume Management ───────────────────────────────────────────────────────

#section("Volume Management")

#subsection("Create & List")
#code(
  ```bash
  # Creates a named volume
  container volume create myvolume

  # Creates a volume with a size limit and ordered journaling
  container volume create --opt size=10g --opt journal=ordered myvolume

  # Lists all volumes
  container volume list

  # Lists only volume names
  container volume list -q
  ```,
)

#subsection("Delete & Prune")
#code(
  ```bash
  # Deletes a single volume by name
  container volume delete myvolume

  # Deletes multiple volumes at once
  container volume delete vol1 vol2 vol3

  # Deletes all volumes
  container volume delete --all

  # Removes all volumes with no container references
  container volume prune
  ```,
)

#note[
  #text(size: 5.8pt)[
    *Anonymous volumes* — created via `-v /path` without a source (named `anon-{uuid}`). Unlike Docker, anonymous volumes do *not* auto-cleanup with `--rm`. Manual deletion is required.
  ]
]

// ─── Builder Management ──────────────────────────────────────────────────────

#section("Builder Management")

#code(
  ```bash
  # Shows BuildKit builder container status
  container builder status

  # Stops the BuildKit builder container
  container builder stop

  # Deletes the builder container
  container builder delete

  # Force-deletes the builder even if still running
  container builder delete --force
  ```,
)

// ─── Cleanup ─────────────────────────────────────────────────────────────────

#section("Cleanup")

#code(
  ```bash
  # Deletes a container by name or ID
  container delete my-web-server

  # Removes all stopped containers to reclaim disk space
  container prune

  # Stops the Apple Containers services
  container system stop
  ```,
)

// ─── Network Management (macOS 26+) ─────────────────────────────────────────

#section("Network Management (macOS 26+)")

#note[
  #text(size: 5.8pt)[
    Available on macOS 26 and later only. Allows creation and management of user-defined container networks.
  ]
]

#subsection("Create & List")
#code(
  ```bash
  # Creates a new user-defined network
  container network create mynet

  # Creates an internal-only network (no external routing)
  container network create --internal mynet

  # Creates a network with a custom subnet
  container network create --subnet 10.10.0.0/24 mynet

  # Lists all networks
  container network list
  ```,
)

#subsection("Delete")
#code(
  ```bash
  # Deletes a network by name
  container network delete mynet
  ```,
)

#subsection("Use a Network")
#code(
  ```bash
  # Runs a container attached to a custom network
  container run --network mynet web-test

  # Runs a container with a specific MAC address on a network
  container run --network default,mac=02:42:ac:11:00:02 ubuntu:latest
  ```,
)

// ─── Container Machine Management ────────────────────────────────────────────

#section("Container Machine Management")

#subsection("Create")
#code(
  ```bash
  # Creates and boots a container machine from an image
  container machine create alpine:3.22

  # Creates a named machine with custom CPU/memory, without booting
  container machine create --name my-machine --cpus 4 --memory 4G --no-boot alpine:3.22
  ```,
)

#subsection("Run Inside a Machine")
#code(
  ```bash
  # Opens an interactive shell in the default container machine
  container machine run

  # Runs a command in a named machine
  container machine run -n my-machine uname -a

  # Passes arguments to the command after --
  container machine run -n my-machine -- cat /proc/cpuinfo
  ```,
)

#subsection("List & Manage")
#code(
  ```bash
  # Lists all container machines (default marked in DEFAULT column)
  container machine list

  # Stops a named machine
  container machine stop -n my-machine

  # Deletes a named machine
  container machine delete -n my-machine
  ```,
)

// ─── Advanced Run Flags ───────────────────────────────────────────────────────

#section("Advanced Run Flags")

#code(
  ```bash
  # Runs with an init process to reap zombies and forward signals
  container run --init ubuntu:latest my-app

  # Runs with a custom init image for boot customization
  container run --init-image local/custom-init:latest ubuntu:latest

  # Mounts the container's root filesystem as read-only
  container run --read-only web-test

  # Adds a tmpfs mount at a given path
  container run --tmpfs /tmp web-test

  # Sets a custom shared memory size for /dev/shm
  container run --shm-size 128M web-test

  # Enables Rosetta translation for x86 binaries
  container run --rosetta web-test

  # Forwards the host SSH agent socket into the container
  container run --ssh web-test

  # Exposes virtualization capabilities to the container
  container run --virtualization web-test

  # Sets a resource ulimit (soft:hard)
  container run --ulimit nofile=1024:2048 web-test
  ```,
)

// ─── System: Kernel, Properties & DNS ────────────────────────────────────────

#section("System: Kernel, Properties & DNS")

#subsection("Kernel Management")
#code(
  ```bash
  # Downloads and installs the recommended default kernel
  container system kernel set --recommended

  # Installs a custom kernel binary
  container system kernel set --binary ./vmlinux --arch arm64

  # Installs a kernel from a tar archive with digest verification
  container system kernel set --tar https://example.com/kernel.tar --digest sha256:abcd1234
  ```,
)

#subsection("System Properties")
#code(
  ```bash
  # Lists all system properties (default TOML format)
  container system property list

  # Lists properties as JSON for scripting
  container system property list --format json
  ```,
)

#subsection("DNS Domains")
#code(
  ```bash
  # Lists configured container DNS domains
  container system dns list

  # Lists DNS domains as JSON, names only
  container system dns list --format json -q
  ```,
)
