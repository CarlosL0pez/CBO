const URL_API = "http://127.0.0.1:5001/api/productos"; 

    function obtenerDatosFormulario() {
        return {
            id_producto: parseInt(document.getElementById('prod-id').value),
            nombre: document.getElementById('prod-nombre').value,
            descripcion: document.getElementById('prod-descripcion').value,
            precio: parseFloat(document.getElementById('prod-precio').value),
            unidades: parseInt(document.getElementById('prod-unidades').value),
            id_estado: parseInt(document.getElementById('prod-estado').value)
        };
    }

    document.getElementById('btnAgregar').addEventListener('click', async () => {
        const datos = obtenerDatosFormulario();
        if(!datos.id_producto || !datos.nombre) return alert("Por favor, llena los campos requeridos.");
        
        try {
            const respuesta = await fetch(`${URL_API}/guardar`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(datos)
            });
            const resultado = await respuesta.json();
            
            alert(resultado.message);
            if(respuesta.ok) {
                document.getElementById('formProductos').reset();
                location.reload(); 
            }
        } catch (error) {
            alert("No se pudo conectar con el servidor de Flask en el puerto 5001.");
        }
    });

    document.getElementById('btnActualizar').addEventListener('click', async () => {
        const datos = obtenerDatosFormulario();
        if(!datos.id_producto) return alert("Especifica el ID del producto a actualizar.");

        try {
            const respuesta = await fetch(`${URL_API}/actualizar`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(datos)
            });
            const resultado = await respuesta.json();
            
            alert(resultado.message);
            if(respuesta.ok) {
                document.getElementById('formProductos').reset();
                location.reload();
            }
        } catch (error) {
            alert("No se pudo conectar con el servidor de Flask en el puerto 5001.");
        }
    });

    document.getElementById('btnEliminar').addEventListener('click', async () => {
        const datos = obtenerDatosFormulario();
        if(!datos.id_producto) return alert("Especifica el ID del producto a actualizar.");

        try {
            const respuesta = await fetch(`${URL_API}/eliminar`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(datos)
            });
            const resultado = await respuesta.json();
            
            alert(resultado.message);
            if(respuesta.ok) {
                document.getElementById('formProductos').reset();
                location.reload();
            }
        } catch (error) {
            alert("No se pudo conectar con el servidor de Flask en el puerto 5001.");
        }
    });