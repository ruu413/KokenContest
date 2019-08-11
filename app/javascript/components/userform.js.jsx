
class Userform extends React.Component {
    constructor(props, context, updater) {
        super(props, context, updater)
    }
    render() {
        return <div>{props.data}a</div>
    }
};


document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <Userform name="React" />,
        document.body.appendChild(document.createElement('div')),
    )
})
