FROM swift:5.3-focal
COPY . ./
RUN swift test --enable-test-discovery
