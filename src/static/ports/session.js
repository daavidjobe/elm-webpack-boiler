
export default app => {
    const SESSION_KEY = 'tsSession';

    // Ports to handle session storage.
    app.ports.saveSession.subscribe(sessionData => {
        let serializedData = JSON.stringify(sessionData);
        console.log('Storing: ', serializedData);
        localStorage.setItem(SESSION_KEY, serializedData);
    });

    app.ports.clearSession.subscribe(() => {
        console.log('Clearing session');
        localStorage.removeItem(SESSION_KEY);
    });

    // If a stored session exists, load it and send to ports.
    const sessionData = JSON.parse(
        localStorage.getItem(SESSION_KEY)
    );

    if (sessionData !== null) {
        app.ports.loadSession.send(sessionData);
    }
}


