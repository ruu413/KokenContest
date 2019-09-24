import { transcode } from 'buffer';
import PropTypes from 'prop-types'
import React from 'react'
import ReactDOM from 'react-dom'

import getTypeStr from './type';
import getGradeStr from './grade';



class RankingTable extends React.Component {
    constructor(props) {
        super(props);
        //console.log(props);
        this.req = new XMLHttpRequest();
        this.req.onreadystatechange = this._getJson.bind(this);
        this.req.open('GET', this.props.jsonurl, true);
        this.req.send(null);
        this.state = {
            entries: []//props.default_entries,
        };
    }
    _getJson() {
        if (this.req.readyState == 4) {  // 通信の完了時
            if (this.req.status == 200) {  // 通信の成功時
                let entries = JSON.parse(this.req.responseText);
                entries.sort((a, b) => {
                    return a.evaluation - b.evaluation
                })
                this.setState({ entries: entries });
                //console.log(JSON.parse(this.req.responseText));
            }
        } else {

        }
    }

    render() {
        return (<React.Fragment>
            <div className="table-responsive"><table className="table"><tbody>
                <tr>
                    {/*<th>発表順</th>*/}
                    <th>部門</th>
                    <th>チーム名</th>
                    <th>作品名</th>
                    <th>説明</th>
                    {/*<th></th>*/}
                    <th></th>
                    <th></th>
                    <th></th></tr>
                {this.state.entries.map((entry) => {
                    return <EntryTr entry={entry} key={entry.id}></EntryTr>;
                })
                }
            </tbody></table></div>

        </React.Fragment>
        )
    }
}
class EntryTr extends React.Component {
    constructor(props) {
        super(props);
    }
    render() {
        //console.log(this.props)
        const span = 1
        //console.log(users_1toE)
        const colwidth = { minWidth: "100px", width: "100px", maxWidth: "100px" };
        const colwidth2 = { minWidth: "70px", width: "70px", maxWidth: "70px" };
        const descrwidth = { minWidth: "200px", maxWidth: "400px" };
        return (
            <React.Fragment>
                <tr>
                    {/*<td rowSpan={span}>
            {this.props.entry.order}
          </td>*/}
                    <td style={colwidth2} rowSpan={span}>
                        {getTypeStr(this.props.entry.type)}
                    </td>
                    <td style={colwidth} rowSpan={span}>
                        {this.props.entry.teamname}
                    </td>
                    <td style={colwidth} rowSpan={span}>
                        {this.props.entry.prodname}
                    </td>
                    <td style={descrwidth} rowSpan={span}>
                        {this.props.entry.description}
                    </td>


                    {/*<td style={colwidth2}><a className="btn-sm btn-secondary active" onClick={() => window.open( '/evaluations/' + this.props.entry.id + "/new" )}>評価</a></td>*/}
                    <td style={colwidth2}><a className="btn-sm btn-secondary active" href={'/entries/' + this.props.entry.id}>詳細</a></td>
                    <td style={colwidth2}><a className="btn-sm btn-secondary active" href={'/entries/' + this.props.entry.id + '/edit'}>編集</a></td>
                    <td style={colwidth2}><a className="btn-sm btn-danger active" data-confirm='Are you sure?' rel='nofollow' data-method='delete' href={'/entries/' + this.props.entry.id}>削除</a></td>

                </tr>
            </React.Fragment>
        );
    }
}

export default RankingTable
