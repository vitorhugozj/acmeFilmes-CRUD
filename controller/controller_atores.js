const message = require('../modulo/config.js');
const sexualidadeDAO = require('../model/DAO/sexoUn.js');
const nacionalidadeDAO = require('../model/DAO/nacionalidadeAtor.js');
const modelAtor = require('../model/DAO/atores.js')


const getBuscarIdAtor = async function (id) {

    try{
        let atorId = id
        let atorJSON = {};

        if(atorId == '' || atorId == undefined || isNaN(atorId)){
            return message.ERROR_INVALID_ID
        }else if(dadosAtor){
            let dadosAtor = await modelAtor.selectAtorById(atorId)
            if(dadosAtor){
                if (dadosAtor.lenght > 0) {
                    for(let ator of dadosAtor){
                        let sexoUnAtor = await sexualidadeDAO.selectByIdSexo(ator.tbl_sexo)
                        delete ator.tbl_sexo
                        ator.sexo = sexoUnAtor
                    }
                } 
                    for(let ator of dadosAtor){
                        let nacionalidadeAtor = await nacionalidadeDAO.selectNacionalidadeAtorById(ator.id)
                        if(nacionalidadeAtor.lenght > 0){
                            ator.nacionalidade = nacionalidadeAtor
                        }
                    }
                atorJSON = dadosAtor;
                atorJSON.status_code = 200;

                return atorJSON
            }else{
                return message.ERROR_NOTFOUND
            };
        }else{
            return message.ERROR_INTERNAL_SERVER_DB
        }
    }catch(error){
        return message.ERROR_INTERNAL_SERVER
    }
}

const getBuscarAtorNome = async function(nome){
    try{
        let nomeDoAtor = nome
        let atoresJSON = {};
        if (nomeDoAtor == '' || nomeDoAtor == undefined || !isNaN(nomeDoAtor))
            return message.ERROR_INVALID_ID
        else{
            let dadosAtor = await modelAtor.selectAtorByNomeAtor(nomeDoAtor)
            if (dadosAtor){
                if (dadosAtor.lenght > 0){
                    for (let ator of dadosAtor) {
                        let sexoUnAtor = await modelAtor.selectByIdSexo(ator.id)
                        ator.sexo = sexoUnAtor
                    }
                    for (let ator of dadosAtor){
                        let nacionalidadeAtor = await nacionalidadeDAO.selectNacionalidadeAtorById(ator.id)
                        if(nacionalidadeDAO.lenght > 0){
                            ator.nacionalidade = nacionalidadeAtor
                        }
                    }
                    atoresJSON.atores = dadosAtor
                    atoresJSON.status_code = 200
                    return atoresJSON
                }else 
                return message.ERROR_NOTFOUND 
            }else 
            return message.ERROR_INTERNAL_SERVER_DB
        }
    }catch(error){
        return message.ERROR_INTERNAL_SERVER
    }
}

const getListarAtores = async function(){
    try{
        let atoresJSON = {};

        let dadosAtor = await modelAtor.selectAllAtores();
    if (dadosAtor) {
         if (dadosAtor.lenght > 0){
                for(let ator of dadosAtor){
                    let sexoUnAtor = await modelAtor.selectByIdSexo(id)
                    ator.sexo = sexoUnAtor
                }
                for (let ator of dadosAtor){
                    let nacionalidadeAtor = await modelAtor.selectNacionalidadeAtorById(ator.id)
                    if(nacionalidadeAtor.lenght > 0){
                        ator.nacionalidade = nacionalidadeAtor
                    }
                }
                atoresJSON.atores = dadosAtor
                atoresJSON.quantidade = dadosAtores.lenght
                atoresJSON.status_code = 200
                return atoresJSON
            }else
                return message.ERROR_NOTFOUND
        }else 
        return message.ERROR_INTERNAL_SERVER_DB
    }catch (error){
        return message.ERROR_INTERNAL_SERVER
    }
}

const setInserirAtor = async function (dadosAtor, contentType){
    try {
        if(String(contentType).toLowerCase()=='application/json'){
            let inserirNovoAtor={}
            let latterId
            if(
            dadosAtores.nome==''            ||dadosAtores.nome==undefined            ||dadosAtores.nome==null            ||dadosAtores.nome.length>120            ||
            dadosAtores.data_nascimento=='' ||dadosAtores.data_nascimento==undefined ||dadosAtores.data_nascimento==null ||dadosAtores.data_nascimento.length!=1  ||
            dadosAtores.biografia==''       ||dadosAtores.biografia==undefined       ||dadosAtores.biografia==null       ||dadosAtores.biografia.length>50000     ||
            dadosAtores.foto==''            ||dadosAtores.foto==undefined            ||dadosAtores.foto==null            ||dadosAtores.foto.length>200            ||
            dadosAtores.sexo[0].nome==''    ||dadosAtores.sexo[0].nome==undefined    ||dadosAtores.sexo[0].nome==null    ||dadosAtores.sexo[0].nome.length>20
            ) {
                return message.ERROR_REQUIRED_FIELDS
            } else{
                let validarStatus=false
                if(dadosAtor.data_falecimento!=null&&dadosAtor.data_falecimento!=''&&dadosAtor.data_falecimento!=undefined){
                    if(dadosAtor.data_falecimento.length!=1){
                        return message.ERROR_REQUIRED_FIELDS
                    }else{
                        validarStatus=true
                    }
                }else{
                    validateStatus=true
                }
                if(validarStatus){
                    let addAtor=await modelAtor.insertNovoAtor(dadosAtor)
                    if(addAtor){
                       
                        inserirNovoAtor.ator= dadosAtor
                        inserirNovoAtor.status=message.SUCESS_CREATED_ITEM.status
                        inserirNovoAtor.status_code=message.SUCESS_CREATED_ITEM.status_code
                        inserirNovoAtor.message=message.SUCESS_CREATED_ITEM.message

                        latterId = await modelAtor.selectLatterId()
                        dadosAtor.id=latterId[0].id  
                        return inserirNovoAtor
                    }
                    else{
                        return message.ERROR_INTERNAL_SERVER_DB
                    }
                }
            }
        }else{
            return message.ERROR_CONTENT_TYPE
        }
    } catch (error) {
        return message.ERROR_INTERNAL_SERVER
    }
}

const setAtualizarAtor = async function (id, dadosAtor, contentType){
    try {
        
        if(String(contentType).toLowerCase()=='application/json'){
             let atorId=id
             
            if(atorId == '' || atorId == undefined || isNaN(atorId))
                return message.ERROR_INVALID_ID
            else{
               
                let ator =await modelAtor.selectAtoresById(atorId)
                if(ator){
                    let atualizarAtorJSON = {}
                    let atualizarAtor = await modelAtor.atualizarAtor(atorId, dadosAtor)
                    if(atualizarAtor){
                        atualizarAtorJSON.ator = dadosAtor
                        atualizarAtor.status = message.SUCESS_UPTADE_ITEM.status
                        atualizarAtor.status_code = message.SUCESS_UPTADE_ITEM.status_code
                        atualizarAtor.message = message.SUCESS_UPTADE_ITEM.message
                        return atualizarAtor
                    }
                    else{
                        return message.ERROR_NOT_FOUND
                    }
                }
                else{
                    return message.ERROR_NOT_FOUND
                }
            }
        } else {
            return message.ERROR_CONTENT_TYPE
        }
    } catch (error) {
        return message.ERROR_INTERNAL_SERVER
    }
}

const setExcluirAtor = async function(id){

    try {

    let atorId = id;

    if(atorId == ''  || atorId == undefined || isNaN (id)){
        return message.ERROR_INVALID_ID //400
    } else {
        let atorById = await modelAtor.selectAtoresById(id)
        
        if(atorById.length > 0){
            let deletarAtor = await modelAtor.deletarAtor(id)

            if (deletarAtor){
                return message.SUCESS_DELETE_ITEM
            } else {
                return message.ERROR_INTERNAL_SERVER_DB
            }
        }else{
            return message.ERROR_NOT_FOUND
        }
        }
    } catch (error) {
        return message.ERROR_INTERNAL_SERVER
    }
}

module.exports = {
    getBuscarIdAtor,
    getBuscarAtorNome,
    getListarAtores,
    setInserirAtor,
    setAtualizarAtor,
    setExcluirAtor
}