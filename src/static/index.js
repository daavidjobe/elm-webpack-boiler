import './styles/main.scss';

import Elm from '../elm/Main.elm';
import setupSessionPorts from './ports/session';


const app = Elm.Main.embed( document.getElementById( 'elmMain' ) );

// Setup ports
setupSessionPorts(app);
